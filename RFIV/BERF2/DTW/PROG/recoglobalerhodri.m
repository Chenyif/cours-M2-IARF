
motsrohdri={'cinq','deux','diviser','dix','douze','huit','moins','neuf','onze','plus','quatre','sept','six','trois','un'};


mat={};
for i=2: length(motsrohdri)


    nomFichier=['../SonsRohdri/SonsObservation_Rohdri/' motsrohdri{i} '_rohdri_2014.wav']
    [matriceFinal,mot]=recoglobale(nomFichier)
    mat{i,mot}=0;
    mat{i,mot} = mat{i,mot}+1;
    
    
end

