/**
 *  A node element represents any kind of node symbol that appears in a
 *	collaboration diagram. A concrete example of this is an
 *	instance symbol.
 *
 *  @author	K Barclay
 */



package diagram;



import java.awt.*;
import java.awt.event.*;
import java.util.*;
import javax.swing.*;

import dialog.EditAttributsDialog;

import window.*;



public abstract class NodeElement	extends ModelElement {
	JPopupMenu popMenu;
	ColliePropertyPanel propertyMenu;
	
    public		NodeElement(int upperLeftX, int upperLeftY) {
    	bounds = new Rectangle(upperLeftX, upperLeftY, DEFAULTWIDTH, DEFAULTHEIGHT);
    	
    	showFlag = true;
    	
    	//propertyMenu = new ColliePropertyPanel();
    	popMenu = new JPopupMenu();
    	ActionListener menuEditListener = new ActionListener() {
    	      public void actionPerformed(ActionEvent event) {
    	        JOptionPane jop = new JOptionPane();
    	        String nom = jop.showInputDialog(null, "Saisissez le nom de l'instance : ", "Edition nom instance", JOptionPane.QUESTION_MESSAGE);
    	        for(int i=0; i<CollieModelPanel.getCollieModelPanel().getDiagram().getModelList().size();i++)
    			{
    				//R�cup�ration de l'�l�ment s�lectionn�
    				if( CollieModelPanel.getCollieModelPanel().getDiagram().getModelList().get(i).isSelected())
    				{
    					CollieModelPanel.getCollieModelPanel().getDiagram().getModelList().get(i).setName(nom);
    					ColliePropertyPanel.getColliePropertyPanel().getNom().setText(nom);
    				}
    			}
    			//M�j de l'affichage
    			CollieModelPanel.getCollieModelPanel().repaint();
    	      }
    	    };
    	    ActionListener menuEditAttributesListener = new ActionListener() {
      	      public void actionPerformed(ActionEvent event) {
      	        EditAttributsDialog newDial = new EditAttributsDialog(CollieFrame.getCollieFrame(), "Edition attribut", true);
      	      }
      	    };
      	  ActionListener menuAffichListener = new ActionListener() {
    	      public void actionPerformed(ActionEvent event) {
    	        
    	        for(int i=0; i<CollieModelPanel.getCollieModelPanel().getDiagram().getModelList().size();i++)
    			{
    				//R�cup�ration de l'�l�ment s�lectionn�
    				if( CollieModelPanel.getCollieModelPanel().getDiagram().getModelList().get(i).isSelected())
    				{
    					CollieModelPanel.getCollieModelPanel().getDiagram().getModelList().get(i).showFlag ^= true;
    				}
    			}
    			//M�j de l'affichage
    			CollieModelPanel.getCollieModelPanel().repaint();
    	      }
    	    };
    	    ActionListener menuSuppListener = new ActionListener() {
      	      public void actionPerformed(ActionEvent event) {
      	    	  for(int i=0; i<CollieModelPanel.getCollieModelPanel().getDiagram().getModelList().size();i++)
      	    	  {
      	    		  //R�cup�ration de l'�l�ment s�lectionn�
      	    		  if( CollieModelPanel.getCollieModelPanel().getDiagram().getModelList().get(i).isSelected())
      	    		  {
      	    			  CollieModelPanel.getCollieModelPanel().getDiagram().getModelList().remove(i);
      	    		  }
      	    	  }
      	    	  //M�j de l'affichage
      	    	  CollieModelPanel.getCollieModelPanel().repaint();
      	      }
      	    };
    	 JMenuItem itemMenu;
    	 popMenu.add(itemMenu = new JMenuItem("Edition instance"));    	 
    	 itemMenu.addActionListener(menuEditListener); 
    	 popMenu.add(itemMenu = new JMenuItem("Edition attributs instance"));    	 
    	 itemMenu.addActionListener(menuEditAttributesListener); 
    	 popMenu.add(itemMenu = new JMenuItem("Affichage attribut"));    	 
    	 itemMenu.addActionListener(menuAffichListener); 
    	 popMenu.add(itemMenu = new JMenuItem("Suppression"));    	 
    	 itemMenu.addActionListener(menuSuppListener); 
    }

    public		NodeElement(Point mousePoint) {
    	this(mousePoint.x, mousePoint.y);
    }
    
    
    
    public boolean	isHit(int mouseX, int mouseY) {
    	return bounds.contains(mouseX, mouseY);
    }
    
    
    
    public Point	getLocation()			{ return bounds.getLocation(); }
    public Rectangle	getBounds()			{ return bounds; }
    
    public void		setLocation(int x, int y)	{ bounds.setLocation(x, y); }
    public void		setLocation(Point point)	{ this.setLocation(point.x, point.y); }
    
    
    
    public String	getName()			{ return name; }
    public void		setName(String name)		{ this.name = name; }
    
    public String	getClassifier()			{ return classifier; }
    public void		setClassifier(String classifier)	{ this.classifier = classifier; }
    
    public ArrayList	getAttributes()			{ return attributes; }
    
    
    
    public boolean	isShowAttributes()		{ return showFlag; }
    public void		setShowAttributes(boolean show)	{ showFlag = show; }
    
    
    
    public void		addRelation(LinkageElement relation) {
        if(relation != null)
            theRelations.add(relation);
    }
    
    
    
    public void		doRightMousePressed(MouseEvent event, Graphics graphicsContext) {
    			popMenu.show((CollieModelPanel)event.getSource(), event.getX(), event.getY());

    }
    
    /*
     *  Pseudo mouse button event handlers for the start of dragging a node. We note
     *	the mouse position for subsequent dragging operations and we also record
     *	the mouse point as the start point of the dragging activity.
     */
    public void		doLeftMousePressed(MouseEvent event, Graphics graphicsContext) {
    	this.setLocation(event.getPoint());
    	//ColliePropertyPanel.getColliePropertyPanel().getClasse().setVisible(true);
    	//Remplissage du panel de propri�t�
    	ColliePropertyPanel.getColliePropertyPanel().setNomElement(this.name);
    	ColliePropertyPanel.getColliePropertyPanel().setClasse(this.classifier);
    	ColliePropertyPanel.getColliePropertyPanel().setListAttributs(this.attributes);
    	//Affichage des attributs d'un noeud sur le diagramme
    	this.draw(graphicsContext);
    	CollieModelPanel.getCollieModelPanel().repaint();
    	
    }
    
    /*
     *  The node has arrived at it new position. Reposition the node according to the
     *	new mouse location.
     */
    public void		doLeftMouseReleased(MouseEvent event, Graphics graphicsContext) {
    	this.setLocation(event.getPoint());
    	this.updateRelations(event.getX(), event.getY());
    	this.draw(graphicsContext);
    	CollieModelPanel.getCollieModelPanel().repaint();
    }
    
    /*
     *	Render the node in its original position to obliterate it, then redraw
     *  it at its new location.
     */
    public void		doLeftMouseDragged(MouseEvent event, Graphics graphicsContext) {
    	this.setLocation(event.getPoint());
    	// this.updateRelations(event.getX(),event.getY());
    	this.draw(graphicsContext);
    	CollieModelPanel.getCollieModelPanel().repaint();
    	// this.updateRelations((int)this.getLocation().getX(),
    	// (int)this.getLocation().getY());
    }
    
    
    
    public void		updateRelations(int offsetX, int offsetY) {
    	final int size = theRelations.size();
    	for(int k = 0; k < size; k++) {
    	    LinkageElement relation = (LinkageElement)theRelations.get(k);
    	    relation.update(this, offsetX, offsetY);
    	}
    }
    
    
    
    public int		getCompassBearing(Point point) {
    	return this.getCompassBearing(point.x, point.y);
    }
    
    public int		getCompassBearing(int x, int y) {
    	if(x < bounds.x && y < bounds.y)
    	    return NORTHWEST;
    	else if(x > (bounds.x + bounds.width) && y < bounds.y)
    	    return NORTHEAST;
    	else if(y < bounds.y)
    	    return NORTH;
    	else if(x < bounds.x && y > (bounds.y + bounds.height))
    	    return SOUTHWEST;
    	else if(x > (bounds.x + bounds.width) && y > (bounds.y + bounds.height))
    	    return SOUTHEAST;
    	else if(y > (bounds.y + bounds.height))
    	    return SOUTH;
    	else if(x < bounds.x)
    	    return WEST;
    	else if(x > (bounds.x + bounds.width))
    	    return EAST;
    	else
    	    return CENTRE;
    }
    
    public boolean		isNorth(final Point point) 			{ return (this.getCompassBearing(point) == NORTH); }
    public boolean		isWest(final Point point) 			{ return (this.getCompassBearing(point) == WEST); }
    public boolean		isEast(final Point point) 			{ return (this.getCompassBearing(point) == EAST); }
    public boolean		isSouth(final Point point) 			{ return (this.getCompassBearing(point) == SOUTH); }
    public boolean		isNortherly(final Point point) 			{ final int compass = this.getCompassBearing(point); return (compass == NORTHWEST || compass == NORTH || compass == NORTHEAST); }
    public boolean		isWesterly(final Point point) 			{ final int compass = this.getCompassBearing(point); return (compass == NORTHWEST || compass == WEST || compass == SOUTHWEST); }
    public boolean		isEasterly(final Point point) 			{ final int compass = this.getCompassBearing(point); return (compass == NORTHEAST || compass == EAST || compass == SOUTHEAST); }
    public boolean		isSoutherly(final Point point) 			{ final int compass = this.getCompassBearing(point); return (compass == SOUTHWEST || compass == SOUTH || compass == SOUTHEAST); }
    public boolean		isLatitudinal(final Point point)		{ final int compass = this.getCompassBearing(point); return (compass == WEST 	|| compass == CENTRE || compass == EAST); }
    public boolean		isLongitudinal(final Point point)		{ final int compass = this.getCompassBearing(point); return (compass == NORTH 	|| compass == CENTRE || compass == SOUTH); }



// ---------- statics -------------------------------------

    public static final int		NORTHWEST	= 0;
    public static final int		NORTH		= 1;
    public static final int		NORTHEAST	= 2;
    public static final int		WEST		= 3;
    public static final int		CENTRE		= 4;
    public static final int		EAST		= 5;
    public static final int		SOUTHWEST	= 6;
    public static final int		SOUTH		= 7;
    public static final int		SOUTHEAST	= 8;
    
    
    
    protected static final int		DEFAULTWIDTH	= 60;
    protected static final int		DEFAULTHEIGHT	= 30;
    
    protected static final String	EDITINSTANCE	= "Edit instance...";
    protected static final String	EDITATTRIBUTES	= "Edit attributes...";
    protected static final String	SHOWATTRIBUTES	= "Show attributes...";
    protected static final String	HIDEATTRIBUTES	= "Hide attributes...";
    protected static final String	DELETEINSTANCE	= "Delete instance";
    
    
    
// ---------- properties ----------------------------------

    protected Rectangle			bounds;
    
    protected String			name		= "";
    protected String			classifier	= "";
    protected ArrayList			attributes	= new ArrayList(8);
    
    protected boolean			showFlag;
    
    protected ArrayList			theRelations	= new ArrayList(8);
    
    protected Point			theMousePoint;		// during dragging
    protected Point			theStartMousePoint;
    
  



}	// class: NodeElement

// ============================================================================
