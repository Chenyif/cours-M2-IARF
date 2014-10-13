package window;

import java.awt.event.ActionEvent;

import javax.swing.AbstractAction;
import javax.swing.ImageIcon;

public class FileSaveAction extends AbstractAction{

	public FileSaveAction(String string, ImageIcon imageIcon) {

		super(string,imageIcon);
	}
	
	public void setEnabled(boolean newValue){
		super.setEnabled(newValue);
		
	}
	

	public void actionPerformed(ActionEvent e) {
		System.out.println(e.getActionCommand());
		
	}

}
