%l----------------------------fonction izay mandeha voalohany rehefa mande ny programme-------------------------------------------
function monome_35
  %ireto ni variable panel rehetra izay andeha ampiasaina
  global panel_droite;
  global panel_re;
  global panel_operation;
  global panel_res;
  global panel_sai;
  
  %ilay fenetre ny programme
  my_fenetre = figure('name','Outils traitement Mathematiques et Signaux','menubar','none','numbertitle','off');
  taille_ecran = get(0,'screensize'); %variable izay mitondra ni avetesan ecran
  centrer_ecran = taille_ecran(3:4)/2; 
  taille_dialogue = [1200 700]; 
  pos_dialogue = centrer_ecran - taille_dialogue/2; 
  set(my_fenetre, 'position',[pos_dialogue taille_dialogue]);
  panel_gauche = uipanel (my_fenetre,"title", "", "position", [.0 .0 .150 .999],"foregroundcolor",[0.000 0.000 0.000],"backgroundcolor",[0.000 0.569 0.851]);
  panel_droite = uipanel (my_fenetre,"title", "", "position",[.150 .0 .845 .999],"foregroundcolor",[0.000 0.000 0.000],"backgroundcolor","w");
  panel_logo = uipanel (panel_gauche,"title", "", "position", [.0 .760 .999 .300],"foregroundcolor",[0.000 0.000 0.000],"backgroundcolor",[0.075 0.384 0.631]);
  uicontrol(panel_logo,'style','text', 'string','GC', 'units','normalized', 'position',[.0 .0 .999 .999],'fontsize',80,'fontweight','bold','FontName','Algerian',"foregroundcolor","w","backgroundcolor",[0.075 0.384 0.631]);
  uicontrol(panel_gauche, 'style','pushbutton', 'string','Mathematiques(Operation)','units','normalized',...
  'position',[.0 .605 .999 .150],'backgroundcolor',[0.075 0.384 0.631],'foregroundcolor',[1.000 1.000 1.000],'FontName','Arial',"callback",{@matrice});
  uicontrol(panel_gauche, 'style','pushbutton', 'string','Signaux(Graphique)','units','normalized',...
  'position',[.0 .454 .999 .150],'backgroundcolor',[0.075 0.384 0.631],'foregroundcolor',[1.000 1.000 1.000],'FontName','Arial',"callback",{@signaux});
  uicontrol(panel_gauche, 'style','pushbutton', 'string','Documentation','units','normalized',...
  'position',[.0 .303 .999 .150],'backgroundcolor',[0.075 0.384 0.631],'foregroundcolor',[1.000 1.000 1.000],'FontName','Arial',"callback",{@documentation});
  uicontrol(panel_gauche, 'style','pushbutton', 'string','A propos','units','normalized',...
  'position',[.0 .152 .999 .150],'backgroundcolor',[0.075 0.384 0.631],'foregroundcolor',[1.000 1.000 1.000],'FontName','Arial',"callback",{@about});
  uicontrol(panel_gauche, 'style','pushbutton', 'string','Quitter','units','normalized',...
  'position',[.0 .0 .999 .150],'backgroundcolor',[0.075 0.384 0.631],'foregroundcolor',[1.000 1.000 1.000],'FontName','Arial',"callback","close"); 
  uicontrol(panel_droite,'style','text', 'string',"Outils traitement Mathematiques et Signaux", 'units','normalized', 'position',[.0 .760 .999 .240],'fontsize',25,'fontweight','bold','FontName','Impact','backgroundcolor',[0.075 0.384 0.631],'foregroundcolor',[1.000 1.000 1.000]);
  panel_tmp =uipanel (panel_droite,"title", "", "position", [.0 .0 .999 .760],"backgroundcolor","w");
  ax = axes(panel_tmp);
  imshow("logo.png");
endfunction

%----------------------------------Ny sokajy Mathematiques -------------------------------------------------

%fonction izay mandeha rehefa manova operation matrice ho an operation une seule matrice
function change_type(h,e)
  global panel_droite;
  global panel_re;
  global panel_operation;
  global panel_res;
  global panel_sai;
  switch (get(h,"value"))
    case 1
      seule_matrice();
    case 2
      deux_matrice();
    case 3
      systeme_equation();
    case 4
      operation_polynome;
    end
  endfunction
  
  %fonction mandeha rehefa  mifidy menu matrice 
  function matrice(bouton,even)
    global panel_droite;
    global panel_re;
    global panel_visualisation;
    global panel_operation;
    global panel_res;
    global panel_sai;
    global champ_ligne;
    global champ_colonne;
    
    delete(allchild(panel_droite));
    uicontrol(panel_droite,'style','text', 'string','Mathematiques', 'units','normalized', 'position',[.0 .9 .999 .1],'fontsize',30,'fontweight','bold','FontName','','backgroundcolor',[0.075 0.384 0.631],'foregroundcolor',[1.000 1.000 1.000]);
    uicontrol(panel_droite,'style','text', 'string',"Type",'units','normalized','position',[.0 .850 .110 .050],'backgroundcolor',[0.075 0.384 0.631],'foregroundcolor',[1.000 1.000 1.000]);
    panel_sai = uipanel (panel_droite,"title", "Entrer le nombre de ligne et colonne", "position", [.0 .720 .999 .12],"foregroundcolor",[0.000 0.000 0.000],"backgroundcolor","w");
    uicontrol(panel_sai,'style','text', 'string',"Nombre de ligne:",'units','normalized','position',[.0 .310 .120 .5],"foregroundcolor",[0.000 0.000 0.000],"backgroundcolor","w");
    champ_ligne = uicontrol(panel_sai,'style','edit', 'string',"1",'units','normalized','position',[.150 .310 .150 .5],"foregroundcolor",[0.000 0.000 0.000],"backgroundcolor","w");
    uicontrol(panel_sai,"style","slider","value",0,"min",10,"max",1,"units","normalized","sliderstep",[0.1 0.01],"position",[.301 .310 .020 .5],"callback",{@augmente,champ_ligne});
    
    
    uicontrol(panel_sai,'style','text', 'string',"Nombre de colonne:",'units','normalized','position',[.4 .310 .120 .5],"foregroundcolor",[0.000 0.000 0.000],"backgroundcolor","w");
    champ_colonne = uicontrol(panel_sai,'style','edit', 'string',"1",'units','normalized','position',[.550 .310 .150 .5],"foregroundcolor",[0.000 0.000 0.000],"backgroundcolor","w");
    uicontrol(panel_sai,"style","slider","value",0,"min",10,"max",1,"units","normalized","sliderstep",[0.1 0.01],"position",[.701 .310 .020 .5],"callback",{@augmente,champ_colonne});
    
    
    btn_cree = uicontrol(panel_sai, 'style','pushbutton', 'string','Creer','units','normalized',...
    'position',[.810 .310 .2 .520],'backgroundcolor',[0.075 0.384 0.631],'foregroundcolor',[1.000 1.000 1.000],'FontName','Arial',"callback",@click_btn_cree_1);
    panel_re = uipanel (panel_droite,"title", "Remplir la matrice", "position", [.0 .420 .999 .3],"foregroundcolor",[0.000 0.000 0.000],"backgroundcolor","w");
    panel_res = uipanel (panel_droite,"title", "Resultat", "position", [.0 .120 .999 .3],'fontsize',12,'fontweight','bold',"foregroundcolor",[0.000 0.000 0.000],"backgroundcolor","w");
    
    
    panel_operation = uipanel (panel_droite,"title", "Operation", "position", [.0 .0 .999 .12],"foregroundcolor",[0.000 0.000 0.000],"backgroundcolor","w");
    uicontrol(panel_operation, 'style','pushbutton', 'string','Valeur propre','units','normalized',...
    'position',[.0 .5 .15 .40],'backgroundcolor',[0.075 0.384 0.631],'foregroundcolor',[1.000 1.000 1.000],'FontName','Arial',"callback",@valeur_propre);
    uicontrol(panel_operation, 'style','pushbutton', 'string','Vecteur propre','units','normalized',...
    'position',[.16 .5 .15 .40],'backgroundcolor',[0.075 0.384 0.631],'foregroundcolor',[1.000 1.000 1.000],'FontName','Arial',"callback",@vecteur_propre);
    uicontrol(panel_operation, 'style','pushbutton', 'string','Decomposition QR','units','normalized',...
    'position',[.32 .5 .15 .40],'backgroundcolor',[0.075 0.384 0.631],'foregroundcolor',[1.000 1.000 1.000],'FontName','Arial',"callback",@decomposition_qr);
    uicontrol(panel_operation, 'style','pushbutton', 'string','Decomposition cholesky','units','normalized',...
    'position',[.48 .5 .15 .40],'backgroundcolor',[0.075 0.384 0.631],'foregroundcolor',[1.000 1.000 1.000],'FontName','Arial',"callback",@decomposition_cholesky);
    uicontrol(panel_operation, 'style','pushbutton', 'string','Norme','units','normalized',...
    'position',[.64 .5 .15 .40],'backgroundcolor',[0.075 0.384 0.631],'foregroundcolor',[1.000 1.000 1.000],'FontName','Arial',"callback",@norme);
    uicontrol(panel_operation, 'style','pushbutton', 'string','valeur singulier','units','normalized',...
    'position',[.8 .5 .15 .40],'backgroundcolor',[0.075 0.384 0.631],'foregroundcolor',[1.000 1.000 1.000],'FontName','Arial',"callback",@svd_matrice);
    
    
    uicontrol(panel_operation, 'style','pushbutton', 'string','Polynome caracteristique','units','normalized',...
    'position',[.0 .0 .15 .40],'backgroundcolor',[0.075 0.384 0.631],'foregroundcolor',[1.000 1.000 1.000],'FontName','Arial',"callback",@polynomes_caracteristique);
    uicontrol(panel_operation, 'style','pushbutton', 'string','Determinant','units','normalized',...
    'position',[.16 .0 .15 .40],'backgroundcolor',[0.075 0.384 0.631],'foregroundcolor',[1.000 1.000 1.000],'FontName','Arial',"callback",@determinant);
    uicontrol(panel_operation, 'style','pushbutton', 'string','Inverse','units','normalized',...
    'position',[.32 .0 .15 .40],'backgroundcolor',[0.075 0.384 0.631],'foregroundcolor',[1.000 1.000 1.000],'FontName','Arial',"callback",@inverse);
    uicontrol(panel_operation, 'style','pushbutton', 'string','Triangularisation','units','normalized',...
    'position',[.48 .0 .15 .40],'backgroundcolor',[0.075 0.384 0.631],'foregroundcolor',[1.000 1.000 1.000],'FontName','Arial',"callback",@triangularisation);
    uicontrol(panel_operation, 'style','pushbutton', 'string','Transposer','units','normalized',...
    'position',[.64 .0 .15 .40],'backgroundcolor',[0.075 0.384 0.631],'foregroundcolor',[1.000 1.000 1.000],'FontName','Arial',"callback",@transposer);
    uicontrol(panel_operation, 'style','pushbutton', 'string','Trace','units','normalized',...
    'position',[.8 .0 .15 .40],'backgroundcolor',[0.075 0.384 0.631],'foregroundcolor',[1.000 1.000 1.000],'FontName','Arial',"callback",@trace_matrice);
    uicontrol(panel_operation, 'style','pushbutton', 'string','Rang','units','normalized',...
    'position',[.960 .0 .030 .89],'backgroundcolor',[0.075 0.384 0.631],'foregroundcolor',[1.000 1.000 1.000],'FontName','Arial',"callback",@rang);
    
    type_matrice = uicontrol(panel_droite,
    'style','popupmenu',
    'string',{'operation avec une seule matrice','Operation avec deux matrices',"Systeme d'equation lineaire","Operation sur les polynomes"},
    'horizontalalignment','cente',
    'units','normalized', 
    'position',[.105 .850 .9 .050],
    'backgroundcolor',[0.075 0.384 0.631],
    'foregroundcolor',[1.000 1.000 1.000],"callback",{@change_type});
  endfunction
  
  %rhf mi click bouton cree aminy operation avec une matrice 
  function click_btn_cree_1
    global panel_droite;
    global panel_re;
    global panel_operation;
    global panel_res;
    global panel_sai;   
    global uitable_matrice;
    global champ_ligne;
    global champ_colonne;
    
    delete(allchild(panel_re));
    delete(allchild(panel_res));
    uicontrol(panel_re,'style','text', 'string',"(", 'units','normalized', 'position',[.250 .250 .050 .7],'fontsize',100,'fontweight','bold','backgroundcolor',"w");
    uicontrol(panel_re,'style','text', 'string',")", 'units','normalized', 'position',[.6 .250 .050 .7],'fontsize',100,'fontweight','bold','backgroundcolor',"w");
    valeur_matrice_zero= zeros(str2num(get(champ_ligne,"string")),str2num(get(champ_colonne,"string")));
    uitable_matrice = uitable (panel_re,'Data',valeur_matrice_zero,"ColumnEditable", true,'units','normalized',"Position",[ .330 .300 .250 .550]);
    
    uicontrol(panel_re, 'style','pushbutton', 'string','Restaurer','units','normalized',...
    'position',[.380 .0 .15 .150],'backgroundcolor',[0.075 0.384 0.631],'foregroundcolor',[1.000 1.000 1.000],'FontName','Arial',"callback",@restaurer_seule);  
  endfunction
  
  %la fonction qui se lance lorsqu'on clique le boutton creer  pour deux  matrices
  function click_btn_cree_2
    global panel_droite;
    global panel_re;
    global panel_operation;
    global panel_res;
    global panel_sai;   
    global uitable_matrice1;
    global uitable_matrice2;
    global champ_ligne1;
    global champ_colonne1;
    global champ_ligne2;
    global champ_colonne2;
    global signe;
    
    delete(allchild(panel_re));
    delete(allchild(panel_res));
    signe =  uicontrol(panel_re,'style','text', 'string',"", 'units','normalized', 'position',[.5 .250 .050 .7],'fontsize',40,'fontweight','bold','backgroundcolor',"w");
    uicontrol(panel_re,'style','text', 'string',"(", 'units','normalized', 'position',[.010 .250 .050 .7],'fontsize',100,'fontweight','bold','backgroundcolor',"w");
    uicontrol(panel_re,'style','text', 'string',")", 'units','normalized', 'position',[.4 .250 .050 .7],'fontsize',100,'fontweight','bold','backgroundcolor',"w");
    uicontrol(panel_re,'style','text', 'string',"(", 'units','normalized', 'position',[.6 .250 .050 .7],'fontsize',100,'fontweight','bold','backgroundcolor',"w");
    uicontrol(panel_re,'style','text', 'string',")", 'units','normalized', 'position',[.940 .250 .050 .7],'fontsize',100,'fontweight','bold','backgroundcolor',"w");
    valeur_matrice_zero1= zeros(str2num(get(champ_ligne1,"string")),str2num(get(champ_colonne1,"string")));
    valeur_matrice_zero2= zeros(str2num(get(champ_ligne2,"string")),str2num(get(champ_colonne2,"string")));
    uitable_matrice1 = uitable (panel_re,'Data',valeur_matrice_zero1,"ColumnEditable", true,'units','normalized',"Position",[ .1 .300 .250 .550]);
    uitable_matrice2 = uitable (panel_re,'Data',valeur_matrice_zero2,"ColumnEditable", true,'units','normalized',"Position",[ .670 .300 .250 .550]);
    
    uicontrol(panel_re, 'style','pushbutton', 'string','Restaurer','units','normalized',...
    'position',[.150 .0 .15 .150],'backgroundcolor',[0.075 0.384 0.631],'foregroundcolor',[1.000 1.000 1.000],'FontName','Arial',"callback",@restaurer1);  
    uicontrol(panel_re, 'style','pushbutton', 'string','Restaurer','units','normalized',...
    'position',[.720 .0 .15 .150],'backgroundcolor',[0.075 0.384 0.631],'foregroundcolor',[1.000 1.000 1.000],'FontName','Arial',"callback",@restaurer2);  
  endfunction
  
  
  %fonction qui calculer la valeur propre propre(lorsqu'on clique le boutton valeur propre)  
  function valeur_propre
    global panel_res;
    global uitable_matrice;
    global champ_ligne;
    global champ_colonne;
    delete(allchild(panel_res));
    
    try
      [vecteurPropre,valeurPropre] = eig(get (uitable_matrice,"Data"));
      for i = 1:1:size(valeurPropre)
        uicontrol(panel_res,'style','text', 'string',strcat("lamda",num2str(i)," = ",num2str(valeurPropre(i,i))), "units","normalized",'position',[.020*(i*5)  .5  .120 .1],'fontsize',8,'fontweight','bold',"backgroundcolor","w");
      endfor
      set(panel_res,"title","Résultat  valeur propre");
    catch
      errordlg("pour calculer  valeur propre il faut que la matrice soit carrer(ligne=colonne)")
    end_try_catch
  endfunction
  
  %fonction qui calculer la vecteur propre (lorsqu'on clique le boutton vecteur propre)   
  function vecteur_propre
    global panel_res;
    global uitable_matrice;
    global champ_ligne;
    global champ_colonne;
    delete(allchild(panel_res));
    
    try
      [vecteurPropre,valeurPropre] = eig(get (uitable_matrice,"Data"));
      uicontrol(panel_res,'style','text', 'string',"(", 'units','normalized', 'position',[.250 .0 .050 .9],'fontsize',100,'fontweight','bold','backgroundcolor',"w");
      uicontrol(panel_res,'style','text', 'string',")", 'units','normalized', 'position',[.650 .0 .050 .9],'fontsize',100,'fontweight','bold','backgroundcolor',"w");
      uicontrol(panel_res,'style','text', 'string',num2str (vecteurPropre, "%5.1f"), 'units','normalized', 'position',[.330 .050 .300 .9],'fontsize',8,'fontweight','bold','backgroundcolor',"w");   
      set(panel_res,"title","Resultat vecteur propre")
    catch
      errordlg("pour calculer  vecteur propre il faut que la matrice soit carrer(ligne=colonne)")
    end_try_catch
  endfunction
  
  %fonction qui calculer transposer (lorsqu'on clique le boutton transposer) 
  function transposer
    global panel_res;
    global uitable_matrice;
    global champ_ligne;
    global champ_colonne;
    delete(allchild(panel_res));
    try
      transpose(get (uitable_matrice,"Data"));
      uicontrol(panel_res,'style','text', 'string',"(", 'units','normalized', 'position',[.250 .0 .050 .9],'fontsize',100,'fontweight','bold','backgroundcolor',"w");
      uicontrol(panel_res,'style','text', 'string',")", 'units','normalized', 'position',[.650 .0 .050 .9],'fontsize',100,'fontweight','bold','backgroundcolor',"w");
      uicontrol(panel_res,'style','text', 'string',num2str (transpose(get (uitable_matrice,"Data")), "%5.1f"), 'units','normalized', 'position',[.330 .050 .300 .9],'fontsize',8,'fontweight','bold','backgroundcolor',"w");
      set(panel_res,"title","Resultat  transposer");
    catch
      errordlg("Verifier la matrice que vous avez saisi")
    end_try_catch
  endfunction
  
  %fonction qui calculer l'inverse  (lorsqu'on clique le boutton inverse) 
  function inverse
    global panel_res;
    global uitable_matrice;
    global champ_ligne;
    global champ_colonne;
    delete(allchild(panel_res)); 
    try
      inv(get (uitable_matrice,"Data"));
      uicontrol(panel_res,'style','text', 'string',"(", 'units','normalized', 'position',[.250 .0 .050 .9],'fontsize',100,'fontweight','bold','backgroundcolor',"w");
      uicontrol(panel_res,'style','text', 'string',")", 'units','normalized', 'position',[.650 .0 .050 .9],'fontsize',100,'fontweight','bold','backgroundcolor',"w");
      uicontrol(panel_res,'style','text', 'string',num2str (inv(get (uitable_matrice,"Data")), "%5.1f"), 'units','normalized', 'position',[.330 .050 .300 .9],'fontsize',8,'fontweight','bold','backgroundcolor',"w");   
      set(panel_res,"title","Resultat inverse") ;
    catch
      errordlg("pour calculer  inverse il faut que la matrice soit carrer(ligne=colonne)")
    end_try_catch
  endfunction
  
  %fonction qui calculer la determinant (lorsqu'on clique le boutton determinant) 
  function determinant  
    global panel_res;
    global uitable_matrice;
    global champ_ligne;
    global champ_colonne;
    delete(allchild(panel_res));
    try
      det(get (uitable_matrice,"Data"));
      uicontrol(panel_res,'style','text', 'string',strcat("determinant de cette matrice est \t ",num2str ( det(get (uitable_matrice,"Data")), "%5.1f")), 'units','normalized', 'position',[.0 .050 .9 .9],'fontsize',12,'fontweight','bold','backgroundcolor',"w");   
      set(panel_res,"title","Resultat determinant");
    catch
      errordlg("pour calculer  le determinant il faut que la matrice soit carrer(ligne=colonne)")
    end_try_catch
    
  endfunction
  
  %fonction qui calculer la trace de la mtrice(lorsqu'on clique le boutton trace)  
  function trace_matrice  
    global panel_res;
    global uitable_matrice;
    global champ_ligne;
    global champ_colonne;
    delete(allchild(panel_res));
    try
      trace(get (uitable_matrice,"Data"));
      uicontrol(panel_res,'style','text', 'string',strcat("Trace de cette matrice est \t",num2str ( trace(get (uitable_matrice,"Data")), "%5.1f")), 'units','normalized', 'position',[.0 .050 .9 .9],'fontsize',12,'fontweight','bold','backgroundcolor',"w");   
      set(panel_res,"title","Resultat trace");
    catch
      errordlg("verifier la matrice que vous avez saisi")
    end_try_catch
  endfunction
  
  %fonction qui calculer la norme(lorsqu'on clique le boutton norme)   
  function norme
    global panel_res;
    global uitable_matrice;
    global champ_ligne;
    global champ_colonne;
    delete(allchild(panel_res));  
    try
      norm(get (uitable_matrice,"Data"));
      uicontrol(panel_res,'style','text', 'string',strcat("la norme de cette matrice est \t ",num2str ( norm(get (uitable_matrice,"Data")), "%5.1f")), 'units','normalized', 'position',[.0 .050 .9 .9],'fontsize',12,'fontweight','bold','backgroundcolor',"w");
      set(panel_res,"title","Resultat norme");
    catch
      errordlg("error on arrive pas a calculer la norme")
    end_try_catch
  endfunction
  
  %fonction qui calculer le rang de la matrice(lorsqu'on clique le boutton rang) 
  function rang
    global panel_res;
    global uitable_matrice;
    global champ_ligne;
    global champ_colonne;
    delete(allchild(panel_res));
    try
      rank(get (uitable_matrice,"Data"));
      uicontrol(panel_res,'style','text', 'string',strcat("Rang de cette matrice est \t ",num2str ( rank(get (uitable_matrice,"Data")), "%5.1f")), 'units','normalized', 'position',[.0 .050 .9 .9],'fontsize',12,'fontweight','bold','backgroundcolor',"w");
      set(panel_res,"title","Resultat rang");
    catch
      errordlg("error on arrive pas a calculer le rang")
      
    end_try_catch
  endfunction
  
  %fonction qui calculer decomposition QR(lorsqu'on clique le boutton decomposition QR)   
  function decomposition_qr
    global panel_res;
    global uitable_matrice;
    global champ_ligne;
    global champ_colonne;
    try
      [Q,R] = qr(get (uitable_matrice,"Data"));
      delete(allchild(panel_res));
      set(panel_res,"title","Resultat decomposition QR");
      uicontrol(panel_res,'style','text', 'string',"Matrice Q(diagonal)", 'units','normalized', 'position',[.120 .80 .200 .060],'fontsize',8,'fontweight','bold','backgroundcolor',"w");
      uicontrol(panel_res,'style','text', 'string',"Matrice R(triangulaire)", 'units','normalized', 'position',[.550 .80 .380 .060],'fontsize',8,'fontweight','bold','backgroundcolor',"w");
      uicontrol(panel_res,'style','text', 'string',"(", 'units','normalized', 'position',[.0 .0 .050 .9],'fontsize',80,'fontweight','bold','backgroundcolor',"w");
      uicontrol(panel_res,'style','text', 'string',")", 'units','normalized', 'position',[.400 .0 .050 .9],'fontsize',80,'fontweight','bold','backgroundcolor',"w");
      uicontrol(panel_res,'style','text', 'string',num2str (Q, "%5.1f"), 'units','normalized', 'position',[.080 .070 .300 .6],'fontsize',8,'fontweight','bold','backgroundcolor',"w");
      uicontrol(panel_res,'style','text', 'string',"(", 'units','normalized', 'position',[.5 .0 .050 .9],'fontsize',80,'fontweight','bold','backgroundcolor',"w");
      uicontrol(panel_res,'style','text', 'string',")", 'units','normalized', 'position',[.9 .0 .050 .9],'fontsize',80,'fontweight','bold','backgroundcolor',"w");
      uicontrol(panel_res,'style','text', 'string',num2str (R, "%5.1f"), 'units','normalized', 'position',[.580 .070 .300 .6],'fontsize',8,'fontweight','bold','backgroundcolor',"w");
    catch
      errordlg("on arrive pas a calculer le decomposition QR")
    end_try_catch   
  endfunction
  
  %fonction qui calculer decomposition cholesky  (lorsqu'on clique le boutton decomposition cholesky )   
  function decomposition_cholesky
    global panel_res;
    global uitable_matrice;
    global champ_ligne;
    global champ_colonne;
    try
      R = chol(get (uitable_matrice,"Data"));
      delete(allchild(panel_res));
      
      set(panel_res,"title","Resultat decomposition Cholesky");
      uicontrol(panel_res,'style','text', 'string',"transposer de R", 'units','normalized', 'position',[.120 .80 .200 .060],'fontsize',8,'fontweight','bold','backgroundcolor',"w");
      uicontrol(panel_res,'style','text', 'string',"Matrice R", 'units','normalized', 'position',[.550 .80 .380 .060],'fontsize',8,'fontweight','bold','backgroundcolor',"w");
      uicontrol(panel_res,'style','text', 'string',"(", 'units','normalized', 'position',[.0 .0 .050 .9],'fontsize',80,'fontweight','bold','backgroundcolor',"w");
      uicontrol(panel_res,'style','text', 'string',")", 'units','normalized', 'position',[.400 .0 .050 .9],'fontsize',80,'fontweight','bold','backgroundcolor',"w");
      uicontrol(panel_res,'style','text', 'string',num2str (transpose(R), "%5.1f"), 'units','normalized', 'position',[.080 .070 .300 .6],'fontsize',8,'fontweight','bold','backgroundcolor',"w");
      uicontrol(panel_res,'style','text', 'string',"(", 'units','normalized', 'position',[.5 .0 .050 .9],'fontsize',80,'fontweight','bold','backgroundcolor',"w");
      uicontrol(panel_res,'style','text', 'string',")", 'units','normalized', 'position',[.9 .0 .050 .9],'fontsize',80,'fontweight','bold','backgroundcolor',"w");
      uicontrol(panel_res,'style','text', 'string',num2str (R, "%5.1f"), 'units','normalized', 'position',[.580 .070 .300 .6],'fontsize',8,'fontweight','bold','backgroundcolor',"w");
    catch
      errordlg("Error:il faut que la matrice soit definiment positive")
    end_try_catch
  endfunction
  
  %fonction qui calculer la triangularisation(lorsqu'on clique le boutton triangularisation) 
  function triangularisation
    global panel_res;
    global uitable_matrice;
    global champ_ligne;
    global champ_colonne;
    try
      inferieur = triu(get (uitable_matrice,"Data"));
      superieure = tril(get (uitable_matrice,"Data"));
      delete(allchild(panel_res));  
      set(panel_res,"title","Resultat triangularisation");
      uicontrol(panel_res,'style','text', 'string',"triangulaire inferieur", 'units','normalized', 'position',[.120 .80 .200 .060],'fontsize',8,'fontweight','bold','backgroundcolor',"w");
      uicontrol(panel_res,'style','text', 'string',"triangulaire superieur", 'units','normalized', 'position',[.550 .80 .380 .060],'fontsize',8,'fontweight','bold','backgroundcolor',"w");
      uicontrol(panel_res,'style','text', 'string',"(", 'units','normalized', 'position',[.0 .0 .050 .9],'fontsize',80,'fontweight','bold','backgroundcolor',"w");
      uicontrol(panel_res,'style','text', 'string',")", 'units','normalized', 'position',[.400 .0 .050 .9],'fontsize',80,'fontweight','bold','backgroundcolor',"w");
      uicontrol(panel_res,'style','text', 'string',num2str (inferieur, "%5.1f"), 'units','normalized', 'position',[.080 .070 .300 .6],'fontsize',8,'fontweight','bold','backgroundcolor',"w");
      uicontrol(panel_res,'style','text', 'string',"(", 'units','normalized', 'position',[.5 .0 .050 .9],'fontsize',80,'fontweight','bold','backgroundcolor',"w");
      uicontrol(panel_res,'style','text', 'string',")", 'units','normalized', 'position',[.9 .0 .050 .9],'fontsize',80,'fontweight','bold','backgroundcolor',"w");
      uicontrol(panel_res,'style','text', 'string',num2str (superieure, "%5.1f"), 'units','normalized', 'position',[.580 .070 .300 .6],'fontsize',8,'fontweight','bold','backgroundcolor',"w");
    catch
      errordlg("Error:on arrive pas a triangulariser cette matrice")
    end_try_catch
  endfunction
  
  %fonction izay mi calcul valeur singulier ny matirisy iray   
  function svd_matrice
    global panel_res;
    global uitable_matrice;
    global champ_ligne;
    global champ_colonne;
    try
      [U,S,V] = svd(get (uitable_matrice,"Data"));
      
      delete(allchild(panel_res));
      
      set(panel_res,"title","Resultat Valeur singulier");
      uicontrol(panel_res,'style','text', 'string',"Matrice U", 'units','normalized', 'position',[.070 .80 .200 .060],'fontsize',8,'fontweight','bold','backgroundcolor',"w");
      uicontrol(panel_res,'style','text', 'string',"Matrice S", 'units','normalized', 'position',[.300 .80 .380 .060],'fontsize',8,'fontweight','bold','backgroundcolor',"w");
      uicontrol(panel_res,'style','text', 'string',"Matrice V", 'units','normalized', 'position',[.620 .80 .380 .060],'fontsize',8,'fontweight','bold','backgroundcolor',"w");
      uicontrol(panel_res,'style','text', 'string',"(", 'units','normalized', 'position',[.0 .0 .050 .9],'fontsize',80,'fontweight','bold','backgroundcolor',"w");
      uicontrol(panel_res,'style','text', 'string',")", 'units','normalized', 'position',[.3 .0 .050 .9],'fontsize',80,'fontweight','bold','backgroundcolor',"w");
      uicontrol(panel_res,'style','text', 'string',"(", 'units','normalized', 'position',[.350 .0 .050 .9],'fontsize',80,'fontweight','bold','backgroundcolor',"w");
      uicontrol(panel_res,'style','text', 'string',")", 'units','normalized', 'position',[.6 .0 .050 .9],'fontsize',80,'fontweight','bold','backgroundcolor',"w");
      uicontrol(panel_res,'style','text', 'string',"(", 'units','normalized', 'position',[.650 .0 .050 .9],'fontsize',80,'fontweight','bold','backgroundcolor',"w");
      uicontrol(panel_res,'style','text', 'string',")", 'units','normalized', 'position',[.940 .0 .050 .9],'fontsize',80,'fontweight','bold','backgroundcolor',"w");
      
      uicontrol(panel_res,'style','text', 'string',num2str (U, "%5.1f"), 'units','normalized', 'position',[.050 .070 .250 .6],'fontsize',8,'fontweight','bold',"backgroundcolor","w");
      uicontrol(panel_res,'style','text', 'string',num2str (S, "%5.1f"), 'units','normalized', 'position',[.400 .070 .200 .6],'fontsize',8,'fontweight','bold',"backgroundcolor","w");
      uicontrol(panel_res,'style','text', 'string',num2str (V, "%5.1f"), 'units','normalized', 'position',[.700 .070 .250 .6],'fontsize',8,'fontweight','bold',"backgroundcolor","w");
      
    catch
      errordlg("Error:on arrive pas a calculer la valeur singulier")
    end_try_catch
  endfunction
  
  %fonction manao calcul  polynomes caracteristique ny matirisy
  function polynomes_caracteristique
    global panel_res;
    global uitable_matrice;
    global champ_ligne;
    global champ_colonne;
    delete(allchild(panel_res));
    try
      uicontrol(panel_res,'style','text', 'string',num2str (poly(get (uitable_matrice,"Data")), "%5.1f"), 'units','normalized', 'position',[.330 .050 .300 .9],'fontsize',8,'fontweight','bold','backgroundcolor',"w");
      set(panel_res,"title","Resultat polynome caracteristique");
    catch
      errordlg("Error:On arrive pas a calculer les polynomes caracteristiques")
    end_try_catch
    
  endfunction
  
  %fonction mandeha rehefa misafidy operation avec une seule matrice
  function seule_matrice()
    global panel_droite;
    global panel_re;
    global panel_operation;
    global panel_res;
    global panel_sai;
    global champ_ligne;
    global champ_colonne;
    
    delete(allchild(panel_operation));
    delete(allchild(panel_re));
    delete(allchild(panel_res));
    delete(allchild(panel_sai));
    set(panel_res,"title","");
    uicontrol(panel_sai,'style','text', 'string',"Nombre de ligne:",'units','normalized','position',[.0 .310 .120 .5],"foregroundcolor",[0.000 0.000 0.000],"backgroundcolor","w");
    champ_ligne = uicontrol(panel_sai,'style','edit', 'string',"1",'units','normalized','position',[.150 .310 .150 .5],"foregroundcolor",[0.000 0.000 0.000],"backgroundcolor","w");
    uicontrol(panel_sai,"style","slider","value",0,"min",10,"max",1,"units","normalized","sliderstep",[0.1 0.01],"position",[.301 .310 .020 .5],"callback",{@augmente,champ_ligne});
    
    uicontrol(panel_sai,'style','text', 'string',"Nombre de colonne:",'units','normalized','position',[.4 .310 .120 .5],"foregroundcolor",[0.000 0.000 0.000],"backgroundcolor","w");
    champ_colonne = uicontrol(panel_sai,'style','edit', 'string',"1",'units','normalized','position',[.550 .310 .150 .5],"foregroundcolor",[0.000 0.000 0.000],"backgroundcolor","w");
    uicontrol(panel_sai,"style","slider","value",0,"min",10,"max",1,"units","normalized","sliderstep",[0.1 0.01],"position",[.701 .310 .020 .5],"callback",{@augmente,champ_colonne});
    
    uicontrol(panel_sai, 'style','pushbutton', 'string','Creer','units','normalized',...
    'position',[.810 .310 .2 .520],'backgroundcolor',[0.075 0.384 0.631],'foregroundcolor',[1.000 1.000 1.000],'FontName','Arial',"callback",@click_btn_cree_1);
    
    uicontrol(panel_operation, 'style','pushbutton', 'string','Valeur propre','units','normalized',...
    'position',[.0 .5 .15 .40],'backgroundcolor',[0.075 0.384 0.631],'foregroundcolor',[1.000 1.000 1.000],'FontName','Arial',"callback",@valeur_propre);
    uicontrol(panel_operation, 'style','pushbutton', 'string','Vecteur propre','units','normalized',...
    'position',[.16 .5 .15 .40],'backgroundcolor',[0.075 0.384 0.631],'foregroundcolor',[1.000 1.000 1.000],'FontName','Arial',"callback",@vecteur_propre);
    uicontrol(panel_operation, 'style','pushbutton', 'string','Decomposition QR','units','normalized',...
    'position',[.32 .5 .15 .40],'backgroundcolor',[0.075 0.384 0.631],'foregroundcolor',[1.000 1.000 1.000],'FontName','Arial',"callback",@decomposition_qr);
    uicontrol(panel_operation, 'style','pushbutton', 'string','Decomposition cholesky','units','normalized',...
    'position',[.48 .5 .15 .40],'backgroundcolor',[0.075 0.384 0.631],'foregroundcolor',[1.000 1.000 1.000],'FontName','Arial',"callback",@decomposition_cholesky);
    uicontrol(panel_operation, 'style','pushbutton', 'string','Norme','units','normalized',...
    'position',[.64 .5 .15 .40],'backgroundcolor',[0.075 0.384 0.631],'foregroundcolor',[1.000 1.000 1.000],'FontName','Arial',"callback",@norme);
    uicontrol(panel_operation, 'style','pushbutton', 'string','valeur singulier','units','normalized',...
    'position',[.8 .5 .15 .40],'backgroundcolor',[0.075 0.384 0.631],'foregroundcolor',[1.000 1.000 1.000],'FontName','Arial',"callback",@svd_matrice);
    
    
    uicontrol(panel_operation, 'style','pushbutton', 'string','Polynome caracteristique','units','normalized',...
    'position',[.0 .0 .15 .40],'backgroundcolor',[0.075 0.384 0.631],'foregroundcolor',[1.000 1.000 1.000],'FontName','Arial',"callback",@polynomes_caracteristique);
    uicontrol(panel_operation, 'style','pushbutton', 'string','Determinant','units','normalized',...
    'position',[.16 .0 .15 .40],'backgroundcolor',[0.075 0.384 0.631],'foregroundcolor',[1.000 1.000 1.000],'FontName','Arial',"callback",@determinant);
    uicontrol(panel_operation, 'style','pushbutton', 'string','Inverse','units','normalized',...
    'position',[.32 .0 .15 .40],'backgroundcolor',[0.075 0.384 0.631],'foregroundcolor',[1.000 1.000 1.000],'FontName','Arial',"callback",@inverse);
    uicontrol(panel_operation, 'style','pushbutton', 'string','Triangularisation','units','normalized',...
    'position',[.48 .0 .15 .40],'backgroundcolor',[0.075 0.384 0.631],'foregroundcolor',[1.000 1.000 1.000],'FontName','Arial',"callback",@triangularisation);
    uicontrol(panel_operation, 'style','pushbutton', 'string','Transposer','units','normalized',...
    'position',[.64 .0 .15 .40],'backgroundcolor',[0.075 0.384 0.631],'foregroundcolor',[1.000 1.000 1.000],'FontName','Arial',"callback",@transposer);
    uicontrol(panel_operation, 'style','pushbutton', 'string','Trace','units','normalized',...
    'position',[.8 .0 .15 .40],'backgroundcolor',[0.075 0.384 0.631],'foregroundcolor',[1.000 1.000 1.000],'FontName','Arial',"callback",@trace_matrice);
    uicontrol(panel_operation, 'style','pushbutton', 'string','Rang','units','normalized',...
    'position',[.960 .0 .030 .89],'backgroundcolor',[0.075 0.384 0.631],'foregroundcolor',[1.000 1.000 1.000],'FontName','Arial',"callback",@rang); 
  endfunction
  
  %fonction mandeha rehefa misafidy ny operation avec deux matrices(Addition,soustraction,......)
  function deux_matrice()
    global panel_droite;
    global panel_re;
    global panel_operation;
    global panel_res;
    global panel_sai;
    global champ_ligne1;
    global champ_colonne1;
    global champ_ligne2;
    global champ_colonne2;
    
    
    delete(allchild(panel_operation));
    delete(allchild(panel_re));
    delete(allchild(panel_res));
    delete(allchild(panel_sai));
    set(panel_res,"title","");
    uicontrol(panel_sai,'style','text', 'string',"Nombre de ligne(Matrice 1):",'units','normalized','position',[.020 .310 .150 .5],"fontsize",8,"foregroundcolor",[0.000 0.000 0.000],"backgroundcolor","w");
    champ_ligne1 = uicontrol(panel_sai,'style','edit', 'string',"1",'units','normalized','position',[.160 .310 .050 .5],"foregroundcolor",[0.000 0.000 0.000],"backgroundcolor","w");
    uicontrol(panel_sai,"style","slider","value",0,"min",10,"max",1,"units","normalized","sliderstep",[0.1 0.01],"position",[.210 .310 .020 .5],"callback",{@augmente,champ_ligne1});
    
    uicontrol(panel_sai,'style','text', 'string',"Nombre de colonne(Matrice 1):",'units','normalized','position',[.240 .310 .150 .5],"fontsize",8,"foregroundcolor",[0.000 0.000 0.000],"backgroundcolor","w");
    champ_colonne1 = uicontrol(panel_sai,'style','edit', 'string',"1",'units','normalized','position',[.390 .310 .050 .5],"foregroundcolor",[0.000 0.000 0.000],"backgroundcolor","w");
    uicontrol(panel_sai,"style","slider","value",0,"min",10,"max",1,"units","normalized","sliderstep",[0.1 0.01],"position",[.440 .310 .020 .5],"callback",{@augmente,champ_colonne1});
    
    
    uicontrol(panel_sai,'style','text', 'string',"Nombre de ligne(Matrice 2):",'units','normalized','position',[.470 .310 .130 .5],"fontsize",8,"foregroundcolor",[0.000 0.000 0.000],"backgroundcolor","w");
    champ_ligne2 = uicontrol(panel_sai,'style','edit', 'string',"1",'units','normalized','position',[.600 .310 .050 .5],"foregroundcolor",[0.000 0.000 0.000],"backgroundcolor","w");
    uicontrol(panel_sai,"style","slider","value",0,"min",10,"max",1,"units","normalized","sliderstep",[0.1 0.01],"position",[.650 .310 .020 .5],"callback",{@augmente,champ_ligne2});
    uicontrol(panel_sai,'style','text', 'string',"Nombre de colonne(Matrice 2):",'units','normalized','position',[.680 .310 .150 .5],"fontsize",8,"foregroundcolor",[0.000 0.000 0.000],"backgroundcolor","w");
    champ_colonne2 = uicontrol(panel_sai,'style','edit', 'string',"1",'units','normalized','position',[.830 .310 .050 .5],"foregroundcolor",[0.000 0.000 0.000],"backgroundcolor","w");
    uicontrol(panel_sai,"style","slider","value",0,"min",10,"max",1,"units","normalized","sliderstep",[0.1 0.01],"position",[.880 .310 .020 .5],"callback",{@augmente,champ_colonne2});
    
    
    uicontrol(panel_sai, 'style','pushbutton', 'string','Creer','units','normalized',...
    'position',[.900 .310 .100 .520],'backgroundcolor',[0.075 0.384 0.631],'foregroundcolor',[1.000 1.000 1.000],'FontName','Arial',"callback",@click_btn_cree_2);
    
    uicontrol(panel_operation, 'style','pushbutton', 'string','Addition','units','normalized',...
    'position',[.0 .5 .15 .40],'backgroundcolor',[0.075 0.384 0.631],'foregroundcolor',[1.000 1.000 1.000],'FontName','Arial',"callback",@addition);
    uicontrol(panel_operation, 'style','pushbutton', 'string','Soustraction','units','normalized',...
    'position',[.16 .5 .15 .40],'backgroundcolor',[0.075 0.384 0.631],'foregroundcolor',[1.000 1.000 1.000],'FontName','Arial',"callback",@soustraction);
    uicontrol(panel_operation, 'style','pushbutton', 'string','Multiplication','units','normalized',...
    'position',[.32 .5 .15 .40],'backgroundcolor',[0.075 0.384 0.631],'foregroundcolor',[1.000 1.000 1.000],'FontName','Arial',"callback",@multiplication);
    uicontrol(panel_operation, 'style','pushbutton', 'string','Produit terme terme','units','normalized',...
    'position',[.48 .5 .15 .40],'backgroundcolor',[0.075 0.384 0.631],'foregroundcolor',[1.000 1.000 1.000],'FontName','Arial',"callback",@produit_terme_terme);
    uicontrol(panel_operation, 'style','pushbutton', 'string','Division terme terme','units','normalized',...
    'position',[.64 .5 .15 .40],'backgroundcolor',[0.075 0.384 0.631],'foregroundcolor',[1.000 1.000 1.000],'FontName','Arial',"callback",@division_terme_terme);
    uicontrol(panel_operation, 'style','pushbutton', 'string','Produit scalaire','units','normalized',...
    'position',[.8 .5 .15 .40],'backgroundcolor',[0.075 0.384 0.631],'foregroundcolor',[1.000 1.000 1.000],'FontName','Arial',"callback",@produit_scalaire);
    uicontrol(panel_operation, 'style','pushbutton', 'string','Exponentiation terme terme','units','normalized',...
    'position',[.0 .0 .15 .40],'backgroundcolor',[0.075 0.384 0.631],'foregroundcolor',[1.000 1.000 1.000],'FontName','Arial',"callback",@exponentation_terme_terme);
    
  endfunction
  %fonction manao calcul l'addition ny matirisy roa
  function addition
    global panel_res;
    global uitable_matrice1;
    global uitable_matrice2;
    global champ_ligne1;
    global champ_colonne1;
    global champ_ligne2;
    global champ_colonne2;
    global signe;
    delete(allchild(panel_res));
    if(str2num(get(champ_ligne1,"string"))==str2num(get(champ_ligne2,"string")) && str2num(get(champ_colonne1,"string"))==str2num(get(champ_colonne2,"string")))
    try
      get(uitable_matrice1,"Data")+get(uitable_matrice2,"Data");
      uicontrol(panel_res,'style','text', 'string',"(", 'units','normalized', 'position',[.250 .0 .050 .9],'fontsize',100,'fontweight','bold','backgroundcolor',"w");
      uicontrol(panel_res,'style','text', 'string',")", 'units','normalized', 'position',[.650 .0 .050 .9],'fontsize',100,'fontweight','bold','backgroundcolor',"w");
      uicontrol(panel_res,'style','text', 'string',num2str (get(uitable_matrice1,"Data")+get(uitable_matrice2,"Data"), "%5.1f"), 'units','normalized', 'position',[.330 .050 .300 .9],'fontsize',8,'fontweight','bold','backgroundcolor',"w");
      set(panel_res,"title","Addition de ces deux matrices")
      set(signe,"string","+");
    catch
      errordlg("Error:on arrive pas a additioner ces deux matrices")
    end_try_catch
  else
    errordlg("Error:pour faire l'addition il faut le nombre de ligne et colonne de la matrice 1 est egal a celui de la matrice 2")
  endif
  
endfunction

%fonction manao calcul soustraction ny matirisy roa
function soustraction
  global panel_res;
  global uitable_matrice1;
  global uitable_matrice2;
  global champ_ligne1;
  global champ_colonne1;
  global champ_ligne2;
  global champ_colonne2;
  global signe;
  delete(allchild(panel_res));
  if(str2num(get(champ_ligne1,"string"))==str2num(get(champ_ligne2,"string")) && str2num(get(champ_colonne1,"string"))==str2num(get(champ_colonne2,"string")))
  try
    get(uitable_matrice1,"Data")-get(uitable_matrice2,"Data");
    uicontrol(panel_res,'style','text', 'string',"(", 'units','normalized', 'position',[.250 .0 .050 .9],'fontsize',100,'fontweight','bold','backgroundcolor',"w");
    uicontrol(panel_res,'style','text', 'string',")", 'units','normalized', 'position',[.650 .0 .050 .9],'fontsize',100,'fontweight','bold','backgroundcolor',"w");
    uicontrol(panel_res,'style','text', 'string',num2str (get(uitable_matrice1,"Data")-get(uitable_matrice2,"Data"), "%5.1f"), 'units','normalized', 'position',[.330 .050 .300 .9],'fontsize',8,'fontweight','bold','backgroundcolor',"w");
    set(panel_res,"title","Soustraction de ces deux matrices");
    set(signe,"string","-");
  catch
    errordlg("Error:on arrive pas a soustraire ces deux matrices")
  end_try_catch
else
  errordlg("Error:pour faire la soustraction il faut le nombre de ligne et colonne de la matrice 1 est egal a celui de la matrice 2")
endif


endfunction

%fonction qui calcul produit matricielle
function multiplication
global panel_res;
global uitable_matrice1;
global uitable_matrice2;
global champ_ligne1;
global champ_colonne1;
global champ_ligne2;
global champ_colonne2;
global signe;
delete(allchild(panel_res));
set(panel_res,"title","Multiplication de ces deux matrices")
set(signe,"string","*");
uicontrol(panel_res,'style','text', 'string',"(", 'units','normalized', 'position',[.250 .0 .050 .9],'fontsize',100,'fontweight','bold','backgroundcolor',"w");
uicontrol(panel_res,'style','text', 'string',")", 'units','normalized', 'position',[.650 .0 .050 .9],'fontsize',100,'fontweight','bold','backgroundcolor',"w");
uicontrol(panel_res,'style','text', 'string',num2str (get(uitable_matrice1,"Data")*get(uitable_matrice2,"Data"), "%5.1f"), 'units','normalized', 'position',[.330 .050 .300 .9],'fontsize',8,'fontweight','bold','backgroundcolor',"w");

endfunction

%fonction manao calcul produit scalaire ny matirisy roa
function produit_scalaire
global panel_res;
global uitable_matrice1;
global uitable_matrice2;
global champ_ligne1;
global champ_colonne1;
global champ_ligne2;
global champ_colonne2;
global signe;
delete(allchild(panel_res));
try
  dot(get(uitable_matrice1,"Data"),get(uitable_matrice2,"Data"));
  uicontrol(panel_res,'style','text', 'string',"(", 'units','normalized', 'position',[.250 .0 .050 .9],'fontsize',100,'fontweight','bold','backgroundcolor',"w");
  uicontrol(panel_res,'style','text', 'string',")", 'units','normalized', 'position',[.650 .0 .050 .9],'fontsize',100,'fontweight','bold','backgroundcolor',"w");
  uicontrol(panel_res,'style','text', 'string',num2str (dot(get(uitable_matrice1,"Data"),get(uitable_matrice2,"Data")), "%5.1f"), 'units','normalized', 'position',[.330 .050 .300 .9],'fontsize',8,'fontweight','bold','backgroundcolor',"w");
  set(panel_res,"title","Produit scalaire de ces deux matrices");
  set(signe,"string","x");
catch
  errordlg("Error:on arrive pas a faire le produit scalaire de ces deux matrices")
end_try_catch
endfunction

%fonction manao calcul produit terme terme ny matirisy roa
function produit_terme_terme
global panel_res;
global uitable_matrice1;
global uitable_matrice2;
global champ_ligne1;
global champ_colonne1;
global champ_ligne2;
global champ_colonne2;
global signe;
delete(allchild(panel_res));
if(str2num(get(champ_ligne1,"string"))==str2num(get(champ_ligne2,"string")) && str2num(get(champ_colonne1,"string"))==str2num(get(champ_colonne2,"string")))
try
  uicontrol(panel_res,'style','text', 'string',"(", 'units','normalized', 'position',[.250 .0 .050 .9],'fontsize',100,'fontweight','bold','backgroundcolor',"w");
  uicontrol(panel_res,'style','text', 'string',")", 'units','normalized', 'position',[.650 .0 .050 .9],'fontsize',100,'fontweight','bold','backgroundcolor',"w");
  uicontrol(panel_res,'style','text', 'string',num2str (get(uitable_matrice1,"Data").*get(uitable_matrice2,"Data"), "%5.1f"), 'units','normalized', 'position',[.330 .050 .300 .9],'fontsize',8,'fontweight','bold','backgroundcolor',"w");
  set(panel_res,"title","Produit terme a terme de ces deux matrices");
  set(signe,"string",".*");
catch
  errordlg("Error:on arrive pas a faire le produit terme terme de ces deux matrices")
end_try_catch
else
errordlg("Error:pour faire la produit terme terme il faut le nombre de ligne et colonne de la matrice 1 est egal a celui de la matrice 2")
endif
endfunction

%fonction manao calcul division terme terme  ny matirisy roa
function division_terme_terme
global panel_res;
global uitable_matrice1;
global uitable_matrice2;
global champ_ligne1;
global champ_colonne1;
global champ_ligne2;
global champ_colonne2;
global signe;
delete(allchild(panel_res));
if(str2num(get(champ_ligne1,"string"))==str2num(get(champ_ligne2,"string")) && str2num(get(champ_colonne1,"string"))==str2num(get(champ_colonne2,"string")))
try
uicontrol(panel_res,'style','text', 'string',"(", 'units','normalized', 'position',[.250 .0 .050 .9],'fontsize',100,'fontweight','bold','backgroundcolor',"w");
uicontrol(panel_res,'style','text', 'string',")", 'units','normalized', 'position',[.650 .0 .050 .9],'fontsize',100,'fontweight','bold','backgroundcolor',"w");
uicontrol(panel_res,'style','text', 'string',num2str (get(uitable_matrice1,"Data")./get(uitable_matrice2,"Data"), "%5.1f"), 'units','normalized', 'position',[.330 .050 .300 .9],'fontsize',8,'fontweight','bold','backgroundcolor',"w");
set(panel_res,"title","Division terme a terme de ces deux matrices");
set(signe,"string","./");
catch
errordlg("Error:on arrive pas a faire la division terme terme de ces deux matrices")
end_try_catch
else
errordlg("Error:pour faire la division terme terme il faut le nombre de ligne et colonne de la matrice 1 est egal a celui de la matrice 2")
endif
endfunction

%fonction manao calcul ny exponentiation terme terme ny matirisy roa
function exponentation_terme_terme
global panel_res;
global uitable_matrice1;
global uitable_matrice2;
global champ_ligne1;
global champ_colonne1;
global champ_ligne2;
global champ_colonne2;
global signe;
delete(allchild(panel_res));
if(str2num(get(champ_ligne1,"string"))==str2num(get(champ_ligne2,"string")) && str2num(get(champ_colonne1,"string"))==str2num(get(champ_colonne2,"string")))

try
uicontrol(panel_res,'style','text', 'string',"(", 'units','normalized', 'position',[.250 .0 .050 .9],'fontsize',100,'fontweight','bold','backgroundcolor',"w");
uicontrol(panel_res,'style','text', 'string',")", 'units','normalized', 'position',[.650 .0 .050 .9],'fontsize',100,'fontweight','bold','backgroundcolor',"w");
uicontrol(panel_res,'style','text', 'string',num2str (get(uitable_matrice1,"Data").^get(uitable_matrice2,"Data"), "%5.1f"), 'units','normalized', 'position',[.330 .050 .300 .9],'fontsize',8,'fontweight','bold','backgroundcolor',"w");
set(panel_res,"title","Exponentiations terme a terme de ces deux matrices");
set(signe,"string",".^");
catch
errordlg("Error:on arrive pas a faire l'exponentiation terme terme de ces deux matrices")
end_try_catch
else
errordlg("Error:pour faire la exponentiations terme terme il faut le nombre de ligne et colonne de la matrice 1 est egal a celui de la matrice 2")
endif
endfunction


%fonction mandeha rehefa mifidy systeme d'equation amin'ny ilay fonction
function systeme_equation()
global panel_droite;
global panel_re;
global panel_operation;
global panel_res;
global panel_sai;
global champ_variable;
global champ_inconnue;
global champ_equation;

delete(allchild(panel_operation));
delete(allchild(panel_re));
delete(allchild(panel_res));
delete(allchild(panel_sai));
set(panel_res,"title","")
uicontrol(panel_sai,'style','text', 'string',"Nom du variable:",'units','normalized','position',[.0 .310 .120 .5],"foregroundcolor",[0.000 0.000 0.000],"backgroundcolor","w");
champ_variable = uicontrol(panel_sai,'style','edit', 'string',"z",'units','normalized','position',[.120 .310 .100 .5],"foregroundcolor",[0.000 0.000 0.000],"backgroundcolor","w");
uicontrol(panel_sai,'style','text', 'string',"Nombre d'inconnue:",'units','normalized','position',[.250 .310 .120 .5],"foregroundcolor",[0.000 0.000 0.000],"backgroundcolor","w");
champ_inconnue = uicontrol(panel_sai,'style','edit', 'string',"1",'units','normalized','position',[.380 .310 .100 .5],"foregroundcolor",[0.000 0.000 0.000],"backgroundcolor","w");
uicontrol(panel_sai,"style","slider","value",0,"min",7,"max",1,"units","normalized","sliderstep",[0.15 0.015],"position",[.480 .310 .020 .5],"callback",{@augmente,champ_inconnue});
uicontrol(panel_sai,'style','text', 'string',"Nombre d'equation:",'units','normalized','position',[.530 .310 .120 .5],"foregroundcolor",[0.000 0.000 0.000],"backgroundcolor","w");
champ_equation = uicontrol(panel_sai,'style','edit', 'string',"1",'units','normalized','position',[.660 .310 .100 .5],"foregroundcolor",[0.000 0.000 0.000],"backgroundcolor","w");
uicontrol(panel_sai,"style","slider","value",0,"min",7,"max",1,"units","normalized","sliderstep",[0.15 0.015],"position",[.760 .310 .020 .5],"callback",{@augmente,champ_equation});
uicontrol(panel_sai, 'style','pushbutton', 'string','Creer','units','normalized',...
'position',[.810 .310 .2 .520],'backgroundcolor',[0.075 0.384 0.631],'foregroundcolor',[1.000 1.000 1.000],'FontName','Arial',"callback",@click_btn_cree_3);
uicontrol(panel_operation, 'style','pushbutton', 'string',"systeme d'equation lineaire",'units','normalized',...
'position',[.050 .3 .88 .50],'backgroundcolor',[0.075 0.384 0.631],'foregroundcolor',[1.000 1.000 1.000],'FontName','Arial',"callback",@calcul_system);

endfunction

%fonction mandeha rehefa mi cree ilay systeme d'equation lineaire
function click_btn_cree_3
global panel_droite;
global panel_re;
global panel_operation;
global panel_res;
global panel_sai;   
global champ_variable;
global champ_inconnue;
global champ_equation;
global matrice_systeme;

delete(allchild(panel_re));
delete(allchild(panel_res));
if(str2num(get(champ_inconnue,"string"))==str2num(get(champ_equation,"string")))
for i = 1:1:str2num(get(champ_inconnue,"string"))
for j = 1:1:str2num(get(champ_inconnue,"string"))+1
matrice_systeme(i,j) = uicontrol(panel_re,'style','edit', 'string',"", "units","normalized",'position',[.060*(j*2)  .99-i/9 .050 .1],"backgroundcolor","w");
if(j<str2num(get(champ_inconnue,"string")))
uicontrol(panel_re,'style','text', 'string',strcat(get(champ_variable,"string"),num2str(j),"   + "), "units","normalized",'position',[.060*(j*2)+0.050  .99-i/9 .050 .1],"backgroundcolor","w");
elseif(j==str2num(get(champ_inconnue,"string")))
uicontrol(panel_re,'style','text', 'string',strcat(get(champ_variable,"string"),num2str(j),"   = "), "units","normalized",'position',[.060*(j*2)+0.050  .99-i/9 .050 .1],"backgroundcolor","w");
endif

endfor
endfor
uicontrol(panel_re,'style','text', 'string',"{", "units","normalized",'position',[.005 .3 .070 .800],'fontsize',100,"backgroundcolor","w");
else
errordlg("Error:il faut que le nombre d'inconnue soit egal au nombre d'equation")
endif

endfunction

%fonction izay manao calcul ny system d'equation lineaire
function calcul_system
global panel_droite;
global panel_re;
global panel_operation;
global panel_res;
global panel_sai;   
global champ_variable;
global champ_inconnue;
global champ_equation;
global matrice_systeme;

delete(allchild(panel_res));
try

for i = 1:1:str2num(get(champ_inconnue,"string"))
for j = 1:1:str2num(get(champ_inconnue,"string"))+1
if(j<=str2num(get(champ_inconnue,"string")))
matrice_m(i,j) =str2double(get(matrice_systeme(i,j),"string")) ;
else
matrice_b(i)=str2double(get(matrice_systeme(i,j),"string"));
endif

endfor
endfor
matrice_b =transpose(matrice_b);
matrice_resultat = matrice_m\matrice_b;
for i = 1:1:size(matrice_resultat)
uicontrol(panel_res,'style','text', 'string',strcat(get(champ_variable,"string"),num2str(i)," = ",num2str(matrice_resultat(i))), "units","normalized",'position',[.020*(i*6)  .5  .150 .1],'fontsize',8,'fontweight','bold',"backgroundcolor","w");
endfor
set(panel_res,"title","Les solutions de cette equation");
catch
errordlg("Error:verifer les equations")
end_try_catch
endfunction

%fonction izay manao operation amna polynome((Deriver,primitive,valeurs et racines d'un polynome)
function operation_polynome
global panel_droite;
global panel_re;
global panel_operation;
global panel_res;
global panel_sai;
global champ_nom_variable;
global champ_degre;

delete(allchild(panel_operation));
delete(allchild(panel_re));
delete(allchild(panel_res));
delete(allchild(panel_sai));
set(panel_res,"title","");
uicontrol(panel_sai,'style','text', 'string',"Nom du variable:",'units','normalized','position',[.0 .310 .120 .5],"foregroundcolor",[0.000 0.000 0.000],"backgroundcolor","w");
champ_nom_variable = uicontrol(panel_sai,'style','edit', 'string',"x",'units','normalized','position',[.150 .310 .150 .5],"foregroundcolor",[0.000 0.000 0.000],"backgroundcolor","w");

uicontrol(panel_sai,'style','text', 'string',"Degrer du polynome",'units','normalized','position',[.4 .310 .120 .5],"foregroundcolor",[0.000 0.000 0.000],"backgroundcolor","w");
champ_degre = uicontrol(panel_sai,'style','edit', 'string',"1",'units','normalized','position',[.550 .310 .150 .5],"foregroundcolor",[0.000 0.000 0.000],"backgroundcolor","w");
uicontrol(panel_sai,"style","slider","value",0,"min",10,"max",1,"units","normalized","sliderstep",[0.1 0.01],"position",[.701 .310 .020 .5],"callback",{@augmente,champ_degre});

uicontrol(panel_sai, 'style','pushbutton', 'string','Creer','units','normalized',...
'position',[.810 .310 .2 .520],'backgroundcolor',[0.075 0.384 0.631],'foregroundcolor',[1.000 1.000 1.000],'FontName','Arial',"callback",@click_btn_cree_polynome);

uicontrol(panel_operation, 'style','pushbutton', 'string','Derive','units','normalized',...
'position',[.0 .3 .49 .50],'backgroundcolor',[0.075 0.384 0.631],'foregroundcolor',[1.000 1.000 1.000],'FontName','Arial',"callback",@calcul_derive);
uicontrol(panel_operation, 'style','pushbutton', 'string','Racines','units','normalized',...
'position',[.50 .3 .49 .50],'backgroundcolor',[0.075 0.384 0.631],'foregroundcolor',[1.000 1.000 1.000],'FontName','Arial',"callback",@calcul_racine);

endfunction

%fonction mandeha rehefa mi cree ilay polynome
function click_btn_cree_polynome
global panel_droite;
global panel_re;
global panel_operation;
global panel_res;
global panel_sai;   
global champ_nom_variable;
global champ_degre;
global poly_nome;

delete(allchild(panel_re));
delete(allchild(panel_res));
if(str2num(get(champ_degre,"string"))>0)
uicontrol(panel_re,'style','text', 'string',strcat("P(",get(champ_nom_variable,"string"),")="), "units","normalized",'position',[.060  .99-4/9 .050 .1],'backgroundcolor','w');

for i = 1:1:str2num(get(champ_degre,"string"))+1
poly_nome(i) = uicontrol(panel_re,'style','edit', 'string',"", "units","normalized",'position',[.060*(i*2)  .99-4/9 .050 .1],'backgroundcolor','w');
if(str2num(get(champ_degre,"string"))-1>=i)
uicontrol(panel_re,'style','text', 'string',strcat(get(champ_nom_variable,"string"),"\t \t \t+"), "units","normalized",'position',[.060*(i*2)+0.050  .99-4/9 .070 .1],'backgroundcolor','w');
uicontrol(panel_re,'style','text', 'string',num2str(str2num(get(champ_degre,"string"))-i+1), "units","normalized",'position',[.060*(i*2)+0.075  .99-3.5/9 .020 .050],"fontsize",7,'backgroundcolor','w');
elseif(i==str2num(get(champ_degre,"string")))
uicontrol(panel_re,'style','text', 'string',strcat(get(champ_nom_variable,"string"),"\t \t \t+"), "units","normalized",'position',[.060*(i*2)+0.050  .99-4/9 .070 .1],'backgroundcolor','w');

endif
endfor
else
errordlg("Error:on arrive pas a cree ce genre de polynome")
endif
endfunction

%fonction mi calcul derive ny ilay polynome nampidirina
function calcul_derive
global panel_droite;
global panel_re;
global panel_operation;
global panel_res;
global panel_sai;   
global champ_nom_variable;
global champ_degre;
global poly_nome;
delete(allchild(panel_res));
try
for i = 1:1:str2num(get(champ_degre,"string"))+1
tmp_poly(i) = str2double(get(poly_nome(i),"string"));  
endfor
derive_poly = polyder(tmp_poly);
uicontrol(panel_res,'style','text', 'string',strcat("P'(",get(champ_nom_variable,"string"),")="), "units","normalized",'position',[.060  .5 .050 .1],'backgroundcolor','w');
for i = 1:1:str2num(get(champ_degre,"string"))
uicontrol(panel_res,'style','text', 'string',num2str(derive_poly(i)), "units","normalized",'position',[.060*(i*2)  .5  .050 .1],'fontsize',8,'fontweight','bold','backgroundcolor','w');
if(str2num(get(champ_degre,"string"))-2>=i)
uicontrol(panel_res,'style','text', 'string',strcat(get(champ_nom_variable,"string"),"\t \t \t+"), "units","normalized",'position',[.060*(i*2)+0.050  .5 .070 .1],'backgroundcolor','w');
uicontrol(panel_res,'style','text', 'string',num2str(str2num(get(champ_degre,"string"))-i), "units","normalized",'position',[.060*(i*2)+0.075  .99-3.6/9 .020 .050],"fontsize",7,'backgroundcolor','w');
elseif(i==str2num(get(champ_degre,"string"))-1)
uicontrol(panel_res,'style','text', 'string',strcat(get(champ_nom_variable,"string"),"\t \t \t+"), "units","normalized",'position',[.060*(i*2)+0.050  .5 .070 .1],'backgroundcolor','w');
endif
endfor
set(panel_res,"title","Deriver de cet polynome");
catch
errordlg("Error:on arrive pas a calculer le derive de ce polynome,s'il vous plait verifier-le")
end_try_catch
endfunction

%fonction mi calcul racines d'un polynome
function calcul_racine
global panel_droite;
global panel_re;
global panel_operation;
global panel_res;
global panel_sai;   
global champ_nom_variable;
global champ_degre;
global poly_nome;
delete(allchild(panel_res));
try

for i = 1:1:str2num(get(champ_degre,"string"))+1
tmp_poly(i) = str2double(get(poly_nome(i),"string"));  
endfor
racine_poly = roots(tmp_poly);

for i = 1:1:str2num(get(champ_degre,"string"))
uicontrol(panel_res,'style','text', 'string',strcat(get(champ_nom_variable,"string"),num2str(i),"=",num2str(racine_poly(i))), "units","normalized",'position',[.020*(i*6)  .5  .150 .1],'fontsize',8,'fontweight','bold','backgroundcolor','w');

endfor
set(panel_res,"title","Les racines de cet polynome");
catch
errordlg("error:on arrive pas a calculer les racines de ce polynome verifiie-le")
end_try_catch




endfunction
%----------------------------------sokajy signaux -------------------------------------------------
function signaux(bouton,even)
global panel_droite;
global panel_operation_signaux;
global panel_courbe;
global panel_fft;
global panel_phase;
global panel_frequence;
global panel_saisi_donner;   
global champ_signal;
global champ_min;
global champ_max;
try
pkg load symbolic;
pkg load signal;
catch
warndlg("cette option require octave version 6 ou superieur")
end_try_catch
delete(allchild(panel_droite));
uicontrol(panel_droite,'style','text', 'string','Signaux', 'units','normalized', 'position',[.0 .9 .999 .1],'fontsize',30,'fontweight','bold','FontName','','backgroundcolor',[0.075 0.384 0.631],'foregroundcolor',[1.000 1.000 1.000]);
uicontrol(panel_droite,'style','text', 'string',"Type du graphe",'units','normalized','position',[.0 .850 .110 .050],'backgroundcolor',[0.075 0.384 0.631],'foregroundcolor',[1.000 1.000 1.000]);
type_signaux = uicontrol(panel_droite,
'style','popupmenu',
'string',{"1D"},
'horizontalalignment','cente',
'units','normalized', 
'position',[.105 .850 .9 .050],
'backgroundcolor',[0.075 0.384 0.631],
'foregroundcolor',[1.000 1.000 1.000],"callback",{@change_type});
panel_saisi_donner = uipanel (panel_droite,"title", "saisir la fonction(variable x)", "position", [.0 .720 .999 .12],"foregroundcolor",[0.000 0.000 0.000],"backgroundcolor","w");
uicontrol(panel_saisi_donner,'style','text', 'string',"fonction signal:",'units','normalized','position',[.0 .310 .120 .5],"foregroundcolor",[0.000 0.000 0.000],"backgroundcolor","w");
champ_signal = uicontrol(panel_saisi_donner,'style','edit', 'string',"entrer ici la fonction",'units','normalized','position',[.110 .310 .380 .5],"foregroundcolor",[0.000 0.000 0.000],"backgroundcolor","w");     
uicontrol(panel_saisi_donner,'style','text', 'string',"min de x: ",'units','normalized','position',[.5 .310 .120 .5],"backgroundcolor","w");
champ_min=uicontrol(panel_saisi_donner,'style','edit', 'string',"-20",'units','normalized', 'position',[.610 .310 .100 .5]);
uicontrol(panel_saisi_donner,'style','text', 'string',"max de x:",'units','normalized','position',[.750 .310 .1 .5],"backgroundcolor","w");
champ_max=uicontrol(panel_saisi_donner,'style','edit', 'string',"20",'units','normalized', 'position',[.860 .310 .100 .5]);

panel_courbe = uipanel (panel_droite,"title", "", "position", [.0 .420 .500 .3],"foregroundcolor",[0.000 0.000 0.000],"backgroundcolor","w");
panel_fft = uipanel (panel_droite,"title", "", "position", [.500 .420 .500 .3],"foregroundcolor",[0.000 0.000 0.000],"backgroundcolor","w");
panel_phase = uipanel (panel_droite,"title", "", "position", [.0 .120 .500 .3],'fontsize',12,'fontweight','bold',"foregroundcolor",[0.000 0.000 0.000],"backgroundcolor","w");
panel_frequence = uipanel (panel_droite,"title", "", "position", [.500 .120 .500 .3],'fontsize',12,'fontweight','bold',"foregroundcolor",[0.000 0.000 0.000],"backgroundcolor","w");

panel_operation_signaux = uipanel (panel_droite,"title", "Operation", "position", [.0 .0 .999 .12],"foregroundcolor",[0.000 0.000 0.000],"backgroundcolor","w");
uicontrol(panel_operation_signaux, 'style','pushbutton', 'string','Transforme de fourier(phase et frequentielle)','units','normalized',...
'position',[.0 .3 .5 .5],'backgroundcolor',[0.075 0.384 0.631],'foregroundcolor',[1.000 1.000 1.000],'FontName','Arial',"callback",@click_transforme_fourier);
uicontrol(panel_operation_signaux, 'style','pushbutton', 'string','Convolution','units','normalized',...
'position',[.5 .3 .5 .5],'backgroundcolor',[0.075 0.384 0.631],'foregroundcolor',[1.000 1.000 1.000],'FontName','Arial',"callback",@click_convolution);
endfunction

function click_transforme_fourier
global panel_courbe;
global panel_fft;
global panel_phase;
global panel_frequence;
global champ_signal;
global champ_min;
global champ_max;

x=str2num(get(champ_min,"string")):0.01:str2num(get(champ_max,"string"));
delete(allchild(panel_courbe));
delete(allchild(panel_fft));
delete(allchild(panel_phase));
delete(allchild(panel_frequence));
try
ax3 = axes(panel_phase);
plot(x,angle(eval(strrep(get(champ_signal,"string"),"*",".*"))))
title("Phase")

ax1 = axes(panel_courbe);
plot(x,eval(strrep(get(champ_signal,"string"),"*",".*")))
title(strcat("Representation graphique de la fonction","\t",get(champ_signal,"string")))

ax1 = axes(panel_fft);
plot(x,fft(eval(strrep(get(champ_signal,"string"),"*",".*"))))
title("Transformer de Fourier discrete")
catch
errordlg("Error:verifier la fonction,pour plus d'aide voir documentation")
end_try_catch

ax2 = axes(panel_frequence);
freqz_plot(ax2,eval(strrep(get(champ_signal,"string"),"*",".*")))
title("Module(frequentielle)");
endfunction

function click_inverse_fourier
global panel_courbe;
global panel_fft;
global panel_phase;
global panel_frequence;
global champ_signal;
x=-5:0.01:5;
delete(allchild(panel_courbe));
delete(allchild(panel_fft));
delete(allchild(panel_phase));
delete(allchild(panel_frequence));

ax3 = axes(panel_phase);
plot(x,angle(eval(strrep(get(champ_signal,"string"),"*",".*"))))
title("Phase")

ax1 = axes(panel_courbe);
plot(x,eval(strrep(get(champ_signal,"string"),"*",".*")))
title(strcat("Representation graphique de la fonction","\t",get(champ_signal,"string")))

ax1 = axes(panel_fft);
plot(x,ifft(eval(strrep(get(champ_signal,"string"),"*",".*"))))
title("Transformer de Fourier discrete inverse")

ax2 = axes(panel_frequence);
freqz_plot(ax2,eval(strrep(get(champ_signal,"string"),"*",".*")))
title("Module(frequentielle)");
endfunction

function click_convolution
global panel_courbe;
global panel_fft;
global panel_phase;
global panel_frequence;
global champ_signal;
global champ_min;
global champ_max;

x=str2num(get(champ_min,"string")):0.01:str2num(get(champ_max,"string"));
delete(allchild(panel_courbe));
delete(allchild(panel_fft));
delete(allchild(panel_phase));
delete(allchild(panel_frequence));
try
ax1 = axes(panel_courbe);
plot(x,eval(strrep(get(champ_signal,"string"),"*",".*")))
title(strcat("Representation graphique de la fonction","\t",get(champ_signal,"string")))

ax1 = axes(panel_fft);
plot(fftconv(eval(strrep(get(champ_signal,"string"),"*",".*")),eval(strrep(get(champ_signal,"string"),"*",".*"))));
title("convolution de cette fonction a elle meme");
catch
errordlg("Error:verifier la fonction,pour plus d'aide voir documentation")
end_try_catch

endfunction

%boite de dialogue documentation
function documentation(bouton,even)
global panel_droite_document;

dialog_document =dialog("name","Aide");
screen_size = get(0,'screensize'); % taille de l'ecran
screen_center = screen_size(3:4)/2; % coordonner x/y du centre de l'ecran
dialog_size = [800 450]; % taille de la fenetre d'application
dialog_pos = screen_center - dialog_size/2; % pour centrer fenetre sur l'ecron
set(dialog_document, 'position',[dialog_pos dialog_size]);%0.000 0.667 1.000
uicontrol(dialog_document,'style','text', 'string','Documentation', 'units','normalized', 'position',[.0 .9 .999 .1],'fontsize',30,'fontweight','bold','FontName','','backgroundcolor',[0.075 0.384 0.631],'foregroundcolor',[1.000 1.000 1.000]);
panel_gauche_document =uipanel (dialog_document,"title", "", "position", [.0 .0 .250 .900]);
uicontrol(panel_gauche_document,'style','text', 'string','Mathematiques(Operations)', 'units','normalized', 'position',[.0 .950 .999 .050],'fontsize',8,'fontweight','bold','FontName','','backgroundcolor',[0.075 0.384 0.631],'foregroundcolor',[1.000 1.000 1.000]);
uicontrol(panel_gauche_document,"style","listbox","string",{"Introduction sur la matrice","Valeur propre","Vecteur propre",...
"Decomposition QR","Decomposition Cholesky","Norme","Valeur Singulier","polynome caracteristique",...
"Determinant","Inverse","Rang","Transposer","Trace","Triangularisation","Addition matrice",...
"Soustraction matrice","Multiplication matrice","Produit terme terme",...
"Division terme terme","Produit scalaire","exponentation terme terme"},"units","normalized","position",[.0 .465 .999 .482],"callback",@click_list_matrice);
uicontrol(panel_gauche_document,'style','text', 'string','Signaux(Graphique)', 'units','normalized', 'position',[.0 .420 .999 .050],'fontsize',8,'fontweight','bold','FontName','','backgroundcolor',[0.075 0.384 0.631],'foregroundcolor',[1.000 1.000 1.000]);
uicontrol(panel_gauche_document,"style","listbox","string",{"Introduction","Les fonctions et operations","Transformer de fourier","Transformer de fourier inverse","Convolution"},"units","normalized","position",[.0 .0 .999 .422],"callback",@click_list_signaux);

panel_droite_document = uipanel(dialog_document,"title", "", "position", [.251 .0 .748 .900],"foregroundcolor","b","backgroundcolor","w");

endfunction

function click_list_matrice(h,e)
global panel_droite_document;
switch (get(h,"value"))
case 1
delete(allchild(panel_droite_document));
uicontrol(panel_droite_document,'style','text', 'string','Introduction sur la matrice', 'units','normalized', 'position',[.0 .9 .999 .1],'fontsize',12,'fontweight','bold','FontName','','foregroundcolor',[0.075 0.384 0.631],'backgroundcolor',"w");
panel_tmp = uipanel(panel_droite_document,"title", "", "position", [.0 .1 .999 .700],"foregroundcolor","b","backgroundcolor","w");

case 2
delete(allchild(panel_droite_document));
uicontrol(panel_droite_document,'style','text', 'string','Valeur propre', 'units','normalized', 'position',[.0 .9 .999 .1],'fontsize',12,'fontweight','bold','FontName','','foregroundcolor',[0.075 0.384 0.631],'backgroundcolor',"w");    
panel_tmp = uipanel(panel_droite_document,"title", "", "position", [.0 .1 .999 .700],"foregroundcolor","b","backgroundcolor","w");
uicontrol(panel_tmp,'style','text', 'string',"Pour calculer valeur propre il faut que la matrice soit carrer(nombre ligne = nombre colonne)", 'units','normalized', 'position',[.0 .8 .999 .1],'fontsize',8,'fontweight','bold','FontName','','foregroundcolor',[0.000 0.000 0.000],'backgroundcolor',"w");

case 3
delete(allchild(panel_droite_document));
uicontrol(panel_droite_document,'style','text', 'string','Vecteur propre', 'units','normalized', 'position',[.0 .9 .999 .1],'fontsize',12,'fontweight','bold','FontName','','foregroundcolor',[0.075 0.384 0.631],'backgroundcolor',"w");    
panel_tmp = uipanel(panel_droite_document,"title", "", "position", [.0 .1 .999 .700],"foregroundcolor","b","backgroundcolor","w");
uicontrol(panel_tmp,'style','text', 'string',"Pour calculer vecteur propre il faut que la matrice soit carrer(nombre ligne = nombre colonne)", 'units','normalized', 'position',[.0 .8 .999 .1],'fontsize',8,'fontweight','bold','FontName','','foregroundcolor',[0.000 0.000 0.000],'backgroundcolor',"w");

case 4
delete(allchild(panel_droite_document));
uicontrol(panel_droite_document,'style','text', 'string','Decomposition QR', 'units','normalized', 'position',[.0 .9 .999 .1],'fontsize',12,'fontweight','bold','FontName','','foregroundcolor',[0.075 0.384 0.631],'backgroundcolor',"w");    
panel_tmp = uipanel(panel_droite_document,"title", "", "position", [.0 .1 .999 .700],"foregroundcolor","b","backgroundcolor","w");

case 5
delete(allchild(panel_droite_document));
uicontrol(panel_droite_document,'style','text', 'string','Decomposition Cholesky', 'units','normalized', 'position',[.0 .9 .999 .1],'fontsize',12,'fontweight','bold','FontName','','foregroundcolor',[0.075 0.384 0.631],'backgroundcolor',"w");    
panel_tmp = uipanel(panel_droite_document,"title", "", "position", [.0 .1 .999 .700],"foregroundcolor","b","backgroundcolor","w");

case 6
delete(allchild(panel_droite_document));
uicontrol(panel_droite_document,'style','text', 'string','Norme', 'units','normalized', 'position',[.0 .9 .999 .1],'fontsize',12,'fontweight','bold','FontName','','foregroundcolor',[0.075 0.384 0.631],'backgroundcolor',"w");    
panel_tmp = uipanel(panel_droite_document,"title", "", "position", [.0 .1 .999 .700],"foregroundcolor","b","backgroundcolor","w");

case 7
delete(allchild(panel_droite_document));
uicontrol(panel_droite_document,'style','text', 'string','Valeur singulier', 'units','normalized', 'position',[.0 .9 .999 .1],'fontsize',12,'fontweight','bold','FontName','','foregroundcolor',[0.075 0.384 0.631],'backgroundcolor',"w");    
panel_tmp = uipanel(panel_droite_document,"title", "", "position", [.0 .1 .999 .700],"foregroundcolor","b","backgroundcolor","w");

case 8
delete(allchild(panel_droite_document));
uicontrol(panel_droite_document,'style','text', 'string','Polynome caracteristique', 'units','normalized', 'position',[.0 .9 .999 .1],'fontsize',12,'fontweight','bold','FontName','','foregroundcolor',[0.075 0.384 0.631],'backgroundcolor',"w");    
panel_tmp = uipanel(panel_droite_document,"title", "", "position", [.0 .1 .999 .700],"foregroundcolor","b","backgroundcolor","w");

case 9
delete(allchild(panel_droite_document));
uicontrol(panel_droite_document,'style','text', 'string','Determinant', 'units','normalized', 'position',[.0 .9 .999 .1],'fontsize',12,'fontweight','bold','FontName','','foregroundcolor',[0.075 0.384 0.631],'backgroundcolor',"w");    
panel_tmp = uipanel(panel_droite_document,"title", "", "position", [.0 .1 .999 .700],"foregroundcolor","b","backgroundcolor","w");
uicontrol(panel_tmp,'style','text', 'string',"Pour calculer le determinant  il faut que la matrice soit carrer(nombre ligne = nombre colonne)", 'units','normalized', 'position',[.0 .8 .999 .1],'fontsize',8,'fontweight','bold','FontName','','foregroundcolor',[0.000 0.000 0.000],'backgroundcolor',"w");

case 10
delete(allchild(panel_droite_document));
uicontrol(panel_droite_document,'style','text', 'string','Inverse', 'units','normalized', 'position',[.0 .9 .999 .1],'fontsize',12,'fontweight','bold','FontName','','foregroundcolor',[0.075 0.384 0.631],'backgroundcolor',"w");    
panel_tmp = uipanel(panel_droite_document,"title", "", "position", [.0 .1 .999 .700],"foregroundcolor","b","backgroundcolor","w");
uicontrol(panel_tmp,'style','text', 'string',"Pour calculer l'inverse d'une matrice il faut que la matrice soit carrer(nombre ligne = nombre colonne)", 'units','normalized', 'position',[.0 .8 .999 .1],'fontsize',8,'fontweight','bold','FontName','','foregroundcolor',[0.000 0.000 0.000],'backgroundcolor',"w");


case 11
delete(allchild(panel_droite_document));
uicontrol(panel_droite_document,'style','text', 'string','Rang', 'units','normalized', 'position',[.0 .9 .999 .1],'fontsize',12,'fontweight','bold','FontName','','foregroundcolor',[0.075 0.384 0.631],'backgroundcolor',"w");    
panel_tmp = uipanel(panel_droite_document,"title", "", "position", [.0 .1 .999 .700],"foregroundcolor","b","backgroundcolor","w");


case 12
delete(allchild(panel_droite_document));
uicontrol(panel_droite_document,'style','text', 'string','Transposer', 'units','normalized', 'position',[.0 .9 .999 .1],'fontsize',12,'fontweight','bold','FontName','','foregroundcolor',[0.075 0.384 0.631],'backgroundcolor',"w");    
panel_tmp = uipanel(panel_droite_document,"title", "", "position", [.0 .1 .999 .700],"foregroundcolor","b","backgroundcolor","w");
uicontrol(panel_tmp,'style','text', 'string','Transposer est la matrice obtenue en échangeant lignes et colonnes dans la matrice A ', 'units','normalized', 'position',[.0 .8 .900 .1],'fontsize',8,'fontweight','bold','FontName','','foregroundcolor',[0.000 0.000 0.000],'backgroundcolor',"w");


case 13
delete(allchild(panel_droite_document));
uicontrol(panel_droite_document,'style','text', 'string','Trace', 'units','normalized', 'position',[.0 .9 .999 .1],'fontsize',12,'fontweight','bold','FontName','','foregroundcolor',[0.075 0.384 0.631],'backgroundcolor',"w");    
panel_tmp = uipanel(panel_droite_document,"title", "", "position", [.0 .1 .999 .700],"foregroundcolor","b","backgroundcolor","w");
uicontrol(panel_tmp,'style','text', 'string','Trace est le scalaire  somme des coefficients de sa diagonale principale', 'units','normalized', 'position',[.0 .8 .900 .1],'fontsize',8,'fontweight','bold','FontName','','foregroundcolor',[0.000 0.000 0.000],'backgroundcolor',"w");

case 14
delete(allchild(panel_droite_document));
uicontrol(panel_droite_document,'style','text', 'string','Triangularisation', 'units','normalized', 'position',[.0 .9 .999 .1],'fontsize',12,'fontweight','bold','FontName','','foregroundcolor',[0.075 0.384 0.631],'backgroundcolor',"w");    
panel_tmp = uipanel(panel_droite_document,"title", "", "position", [.0 .1 .999 .700],"foregroundcolor","b","backgroundcolor","w");

case 15
delete(allchild(panel_droite_document));
uicontrol(panel_droite_document,'style','text', 'string','Addition matrice', 'units','normalized', 'position',[.0 .9 .999 .1],'fontsize',12,'fontweight','bold','FontName','','foregroundcolor',[0.075 0.384 0.631],'backgroundcolor',"w");    
panel_tmp = uipanel(panel_droite_document,"title", "", "position", [.0 .1 .999 .700],"foregroundcolor","b","backgroundcolor","w");
uicontrol(panel_tmp,'style','text', 'string','Soit A = (aij) et B = (bij) deux matrices de même ordre (n,p). La matrice A + B est la', 'units','normalized', 'position',[.0 .8 .900 .1],'fontsize',8,'fontweight','bold','FontName','','foregroundcolor',[0.000 0.000 0.000],'backgroundcolor',"w");
uicontrol(panel_tmp,'style','text', 'string','matrice d‘ordre (n,p) obtenue en additionnant terme à terme les éléments de A et B. ', 'units','normalized', 'position',[.0 .7 .9 .1],'fontsize',8,'fontweight','bold','FontName','','foregroundcolor',[0.000 0.000 0.000],'backgroundcolor',"w");

case 16
delete(allchild(panel_droite_document));
uicontrol(panel_droite_document,'style','text', 'string','Soustraction matrice', 'units','normalized', 'position',[.0 .9 .999 .1],'fontsize',12,'fontweight','bold','FontName','','foregroundcolor',[0.075 0.384 0.631],'backgroundcolor',"w");    
panel_tmp = uipanel(panel_droite_document,"title", "", "position", [.0 .1 .999 .700],"foregroundcolor","b","backgroundcolor","w");
uicontrol(panel_tmp,'style','text', 'string','Soit A = (aij) et B = (bij) deux matrices de même ordre (n,p). La matrice A - B est la', 'units','normalized', 'position',[.0 .8 .900 .1],'fontsize',8,'fontweight','bold','FontName','','foregroundcolor',[0.000 0.000 0.000],'backgroundcolor',"w");
uicontrol(panel_tmp,'style','text', 'string','matrice d‘ordre (n,p) obtenue en soustrant terme à terme les éléments de A et B. ', 'units','normalized', 'position',[.0 .7 .9 .1],'fontsize',8,'fontweight','bold','FontName','','foregroundcolor',[0.000 0.000 0.000],'backgroundcolor',"w");


case 17
delete(allchild(panel_droite_document));
uicontrol(panel_droite_document,'style','text', 'string','multiplication matrice', 'units','normalized', 'position',[.0 .9 .999 .1],'fontsize',12,'fontweight','bold','FontName','','foregroundcolor',[0.075 0.384 0.631],'backgroundcolor',"w");    
panel_tmp = uipanel(panel_droite_document,"title", "", "position", [.0 .1 .999 .700],"foregroundcolor","b","backgroundcolor","w");

case 18
delete(allchild(panel_droite_document));
uicontrol(panel_droite_document,'style','text', 'string','Produit terme terme', 'units','normalized', 'position',[.0 .9 .999 .1],'fontsize',12,'fontweight','bold','FontName','','foregroundcolor',[0.075 0.384 0.631],'backgroundcolor',"w");    
panel_tmp = uipanel(panel_droite_document,"title", "", "position", [.0 .1 .999 .700],"foregroundcolor","b","backgroundcolor","w");

case 19
delete(allchild(panel_droite_document));
uicontrol(panel_droite_document,'style','text', 'string','Division terme terme', 'units','normalized', 'position',[.0 .9 .999 .1],'fontsize',12,'fontweight','bold','FontName','','foregroundcolor',[0.075 0.384 0.631],'backgroundcolor',"w");    
panel_tmp = uipanel(panel_droite_document,"title", "", "position", [.0 .1 .999 .700],"foregroundcolor","b","backgroundcolor","w");

case 20
delete(allchild(panel_droite_document));
uicontrol(panel_droite_document,'style','text', 'string','Produit scalaire', 'units','normalized', 'position',[.0 .9 .999 .1],'fontsize',12,'fontweight','bold','FontName','','foregroundcolor',[0.075 0.384 0.631],'backgroundcolor',"w");    
panel_tmp = uipanel(panel_droite_document,"title", "", "position", [.0 .1 .999 .700],"foregroundcolor","b","backgroundcolor","w");


case 21
delete(allchild(panel_droite_document));
uicontrol(panel_droite_document,'style','text', 'string','exponentation terme terme', 'units','normalized', 'position',[.0 .9 .999 .1],'fontsize',12,'fontweight','bold','FontName','','foregroundcolor',[0.075 0.384 0.631],'backgroundcolor',"w");    
panel_tmp = uipanel(panel_droite_document,"title", "", "position", [.0 .1 .999 .700],"foregroundcolor","b","backgroundcolor","w");

end
endfunction

function click_list_signaux(h,e)
global panel_droite_document;
switch (get(h,"value"))
case 1
delete(allchild(panel_droite_document));
uicontrol(panel_droite_document,'style','text', 'string','Introduction aux signaux', 'units','normalized', 'position',[.0 .9 .999 .1],'fontsize',12,'fontweight','bold','FontName','','foregroundcolor',[0.075 0.384 0.631],'backgroundcolor',"w");
panel_tmp = uipanel(panel_droite_document,"title", "", "position", [.0 .1 .999 .700],"foregroundcolor","b","backgroundcolor","w");
uicontrol(panel_tmp,'style','text', 'string','Definition', 'units','normalized', 'position',[.0 .9 .150 .1],'fontsize',8,'fontweight','bold','FontName','','foregroundcolor',"r",'backgroundcolor',"w");
uicontrol(panel_tmp,'style','text', 'string','Un signal est la représentation physique de l’information', 'units','normalized', 'position',[.0 .8 .6 .1],'fontsize',8,'fontweight','bold','FontName','','foregroundcolor',[0.000 0.000 0.000],'backgroundcolor',"w");
uicontrol(panel_tmp,'style','text', 'string','Objectif', 'units','normalized', 'position',[.0 .6 .150 .1],'fontsize',8,'fontweight','bold','FontName','','foregroundcolor',"r",'backgroundcolor',"w");
uicontrol(panel_tmp,'style','text', 'string',"cet outils nous permet de tracer les signaux à l'aide du fonction que nous introduirons", 'units','normalized', 'position',[.0 .5 .9 .1],'fontsize',8,'fontweight','bold','FontName','','foregroundcolor',[0.000 0.000 0.000],'backgroundcolor',"w");

case 2
delete(allchild(panel_droite_document));
uicontrol(panel_droite_document,'style','text', 'string','Les fonctions et operations', 'units','normalized', 'position',[.0 .9 .999 .1],'fontsize',12,'fontweight','bold','FontName','','foregroundcolor',[0.075 0.384 0.631],'backgroundcolor',"w");    
panel_tmp = uipanel(panel_droite_document,"title", "", "position", [.0 .1 .999 .700],"foregroundcolor","b","backgroundcolor","w");
uicontrol(panel_tmp,'style','text', 'string','les fonctions particulier:', 'units','normalized', 'position',[.0 .9 .250 .1],'fontsize',8,'fontweight','bold','FontName','','foregroundcolor',"r",'backgroundcolor',"w");
uicontrol(panel_tmp,'style','text', 'string','voici comment  tracer une fonction particulier comme rectangle,triangle,ect sur cet outils:', 'units','normalized', 'position',[.0 .8 .900 .1],'fontsize',8,'fontweight','bold','FontName','','foregroundcolor',[0.000 0.000 0.000],'backgroundcolor',"w");
uicontrol(panel_tmp,'style','text', 'string','rectangle:  rectpuls(x,4) avec x est la variable ,4 largeur du rectangle', 'units','normalized', 'position',[.0 .7 .8 .1],'fontsize',8,'fontweight','bold','FontName','','foregroundcolor',[0.000 0.000 0.000],'backgroundcolor',"w");
uicontrol(panel_tmp,'style','text', 'string','triangle:  tripuls(x,4,0) avec x est la variable ,4 largeur du triangle et 0 le centre', 'units','normalized', 'position',[.0 .6 .900 .1],'fontsize',8,'fontweight','bold','FontName','','foregroundcolor',[0.000 0.000 0.000],'backgroundcolor',"w");
uicontrol(panel_tmp,'style','text', 'string','echelon:heaviside(x) avec x est la variable', 'units','normalized', 'position',[.0 .5 .545 .1],'fontsize',8,'fontweight','bold','FontName','','foregroundcolor',[0.000 0.000 0.000],'backgroundcolor',"w");

uicontrol(panel_tmp,'style','text', 'string','les operations arithmetique:', 'units','normalized', 'position',[.0 .4 .300 .1],'fontsize',8,'fontweight','bold','FontName','','foregroundcolor',"r",'backgroundcolor',"w");
uicontrol(panel_tmp,'style','text', 'string','Addition: tout simplement le +', 'units','normalized', 'position',[.0 .3 .4 .1],'fontsize',8,'fontweight','bold','FontName','','foregroundcolor',[0.000 0.000 0.000],'backgroundcolor',"w");
uicontrol(panel_tmp,'style','text', 'string','Soustraction: tout simplement -', 'units','normalized', 'position',[.0 .2 .4 .1],'fontsize',8,'fontweight','bold','FontName','','foregroundcolor',[0.000 0.000 0.000],'backgroundcolor',"w");
uicontrol(panel_tmp,'style','text', 'string','multiplication et division:tout simplement * et /', 'units','normalized', 'position',[.0 .1 .545 .1],'fontsize',8,'fontweight','bold','FontName','','foregroundcolor',[0.000 0.000 0.000],'backgroundcolor',"w");
uicontrol(panel_tmp,'style','text', 'string','puissance:c"est .^ il y a un point devant le ^', 'units','normalized', 'position',[.0 .0 .540 .1],'fontsize',8,'fontweight','bold','FontName','','foregroundcolor',[0.000 0.000 0.000],'backgroundcolor',"w");

case 3
delete(allchild(panel_droite_document));
uicontrol(panel_droite_document,'style','text', 'string',"Transformer de fourier", 'units','normalized', 'position',[.0 .9 .999 .1],'fontsize',12,'fontweight','bold','FontName','','foregroundcolor',[0.075 0.384 0.631],'backgroundcolor',"w");    
panel_tmp = uipanel(panel_droite_document,"title", "", "position", [.0 .1 .999 .700],"foregroundcolor","b","backgroundcolor","w");
uicontrol(panel_tmp,'style','text', 'string','Description', 'units','normalized', 'position',[.0 .9 .150 .1],'fontsize',8,'fontweight','bold','FontName','','foregroundcolor',"r",'backgroundcolor',"w");
uicontrol(panel_tmp,'style','text', 'string','La transformée de Fourier d’un signal réel est une fonction complexe telle que', 'units','normalized', 'position',[.0 .8 .850 .1],'fontsize',8,'fontweight','bold','FontName','','foregroundcolor',[0.000 0.000 0.000],'backgroundcolor',"w");
uicontrol(panel_tmp,'style','text', 'string','son module est une fonction paire de f,', 'units','normalized', 'position',[.0 .7 .6 .1],'fontsize',8,'fontweight','bold','FontName','','foregroundcolor',[0.000 0.000 0.000],'backgroundcolor',"w");
uicontrol(panel_tmp,'style','text', 'string','sa phase est une fonction impaire de f.', 'units','normalized', 'position',[.0 .6 .6 .1],'fontsize',8,'fontweight','bold','FontName','','foregroundcolor',[0.000 0.000 0.000],'backgroundcolor',"w");
uicontrol(panel_tmp,'style','text', 'string','(Appuyer sur le bouton transformer de fourier pour le tracer)', 'units','normalized', 'position',[.0 .5 .8 .1],'fontsize',8,'fontweight','bold','FontName','','foregroundcolor',[0.000 0.000 0.000],'backgroundcolor',"w"); 
case 4
delete(allchild(panel_droite_document));
uicontrol(panel_droite_document,'style','text', 'string',"Transformer de fourier inverse", 'units','normalized', 'position',[.0 .9 .999 .1],'fontsize',12,'fontweight','bold','FontName','','foregroundcolor',[0.075 0.384 0.631],'backgroundcolor',"w");    
panel_tmp = uipanel(panel_droite_document,"title", "", "position", [.0 .1 .999 .700],"foregroundcolor","b","backgroundcolor","w");
uicontrol(panel_tmp,'style','text', 'string','Description', 'units','normalized', 'position',[.0 .9 .150 .1],'fontsize',8,'fontweight','bold','FontName','','foregroundcolor',"r",'backgroundcolor',"w");
uicontrol(panel_tmp,'style','text', 'string','La transformée de Fourier inverse n"est rien d"autre que la fonction signal', 'units','normalized', 'position',[.0 .8 .830 .1],'fontsize',8,'fontweight','bold','FontName','','foregroundcolor',[0.000 0.000 0.000],'backgroundcolor',"w");

case 5
delete(allchild(panel_droite_document));
uicontrol(panel_droite_document,'style','text', 'string',"Convolution", 'units','normalized', 'position',[.0 .9 .999 .1],'fontsize',12,'fontweight','bold','FontName','','foregroundcolor',[0.075 0.384 0.631],'backgroundcolor',"w");        
panel_tmp = uipanel(panel_droite_document,"title", "", "position", [.0 .1 .999 .700],"foregroundcolor","b","backgroundcolor","w");
uicontrol(panel_tmp,'style','text', 'string','Description', 'units','normalized', 'position',[.0 .9 .150 .1],'fontsize',8,'fontweight','bold','FontName','','foregroundcolor',"r",'backgroundcolor',"w");
uicontrol(panel_tmp,'style','text', 'string','convolution ici c"est le produit du signal a lui meme', 'units','normalized', 'position',[.0 .8 .600 .1],'fontsize',8,'fontweight','bold','FontName','','foregroundcolor',[0.000 0.000 0.000],'backgroundcolor',"w");

end
endfunction

function about(bouton,even)
dialog_about =dialog("name","Aide");
screen_size = get(0,'screensize'); % taille de l'ecran
screen_center = screen_size(3:4)/2; % coordonner x/y du centre de l'ecran
dialog_size = [800 450]; % taille de la fenetre d'application
dialog_pos = screen_center - dialog_size/2; % pour centrer fenetre sur l'ecron
set(dialog_about, 'position',[dialog_pos dialog_size]);%0.000 0.667 1.000
uicontrol(dialog_about,'style','text', 'string','A propos', 'units','normalized', 'position',[.0 .9 .999 .1],'fontsize',30,'fontweight','bold','FontName','','backgroundcolor',[0.075 0.384 0.631],'foregroundcolor',[1.000 1.000 1.000]);
panel_about =uipanel (dialog_about,"title", "", "position", [.0 .0 .999 .900],"backgroundcolor","w");
%decription
uicontrol(panel_about,'style','text', 'string','Description:', 'units','normalized', 'position',[.0 .9 .140 .1],'fontsize',12,'fontweight','bold','FontName','','backgroundcolor',"w");
uicontrol(panel_about,'style','text', 'string','un outil de traitement de mathématiques comme les opérations avec les matrices et traitement des signaux représentation graphique', 'units','normalized', 'position',[.150 .9 .790 .1],'fontsize',9,'FontName','','backgroundcolor',"w");
%developpeur
uicontrol(panel_about,'style','text', 'string','Developpeur:', 'units','normalized', 'position',[.0 .7 .150 .1],'fontsize',12,'fontweight','bold','FontName','','backgroundcolor',"w");
uicontrol(panel_about,'style','text', 'string','Monome 35', 'units','normalized', 'position',[.150 .7 .100 .1],'fontsize',10,'FontName','','backgroundcolor',"w");
%version
uicontrol(panel_about,'style','text', 'string','Version:', 'units','normalized', 'position',[.0 .5 .100 .1],'fontsize',12,'fontweight','bold','FontName','','backgroundcolor',"w");
uicontrol(panel_about,'style','text', 'string','1.0', 'units','normalized', 'position',[.100 .5 .070 .1],'fontsize',10,'FontName','','backgroundcolor',"w");

endfunction

%-------------------------fonction izay mampiakatra sy mampidina ny ligne sy colonne ilay matirisy--------------------------
function augmente(h,e,champ)
set(champ,"string",num2str(get(h,"value"),"%5.0f"));
endfunction

function restaurer1
global uitable_matrice1;
global champ_ligne1;
global champ_colonne1;
valeur_matrice_zero1= zeros(str2num(get(champ_ligne1,"string")),str2num(get(champ_colonne1,"string")));
set(uitable_matrice1,"Data",valeur_matrice_zero1);

endfunction

function restaurer2
global uitable_matrice2;
global champ_ligne2;
global champ_colonne2;
valeur_matrice_zero2= zeros(str2num(get(champ_ligne2,"string")),str2num(get(champ_colonne2,"string")));
set(uitable_matrice2,"Data",valeur_matrice_zero2);
endfunction

function restaurer_seule
global uitable_matrice;
global champ_ligne;
global champ_colonne;
valeur_matrice_zero= zeros(str2num(get(champ_ligne,"string")),str2num(get(champ_colonne,"string")));
set(uitable_matrice,"Data",valeur_matrice_zero);
endfunction