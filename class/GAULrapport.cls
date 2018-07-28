%--------------------------------------------------------------------------------------
%----------------------------------- identification -----------------------------------
%--------------------------------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{GAULrapport}%
              [2011/01/14 v1.1h Classe de rapport technique - Universite Laval]
              
%--------------------------------------------------------------------------------------
%------------------------------------ initial code ------------------------------------
%--------------------------------------------------------------------------------------

% Flags logiques permettant l'insertion des listes des figures et des tableaux
\RequirePackage{ifthen}
\newboolean{InsererListeDesFigures}
\newboolean{InsererListeDesTableaux}


%--------------------------------------------------------------------------------------
%------------------------------- declaration of options -------------------------------
%--------------------------------------------------------------------------------------
\DeclareOption{ULlof}{\setboolean{InsererListeDesFigures}{true}}
\DeclareOption{ULlot}{\setboolean{InsererListeDesTableaux}{true}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}

%--------------------------------------------------------------------------------------
%-------------------------------- execution of options --------------------------------
%--------------------------------------------------------------------------------------
\ProcessOptions \relax

%--------------------------------------------------------------------------------------
%----------------------------------- package loading ----------------------------------
%--------------------------------------------------------------------------------------
\LoadClass{report}

\RequirePackage{geometry}
\RequirePackage{lmodern}
\RequirePackage[T1]{fontenc}
\RequirePackage[USenglish,french]{babel}
\RequirePackage{caption}
\RequirePackage{textcomp}        % pour \textcelsius, \textmu, \textohm
\RequirePackage{array}
\RequirePackage{amstext}         % pour \text
\RequirePackage{tabularx}
\RequirePackage{colortbl}
\RequirePackage{longtable}
\RequirePackage{graphicx}
\RequirePackage{rotating}
% \RequirePackage{mathabx}         % pour \second (peut etre remplace par "\prime\prime")
% \RequirePackage{color}
\RequirePackage[hyphens]{url}
\RequirePackage{hyperref}

%--------------------------------------------------------------------------------------
%-------------------------------------- main code -------------------------------------
%--------------------------------------------------------------------------------------

% Definitions des parametres du package hyperref
\hypersetup{plainpages=false,%
            breaklinks=false,%
            colorlinks=true}

% Definitions des dimensions de la page (package geometry)
\geometry{letterpaper,%
          centering,%
          hmargin={2.5cm,2.5cm},%
          vmargin={2.5cm,2.5cm},%
          heightrounded,%
          includehead}

% Utilisation du package "caption" pour
%    - redefinit le caractere de separation dans les legendes comme "babel" le definit,
%      car "caption" (ou "float", le cas echeant) le redefinit comme ":"
%    - uniformise les legendes entre table, longtable et supertabular
%    - specifie que la legende des tableaux sera placee en haut,
%      donc intervertit les dimensions d'espacements (avant et apres la legende)
\DeclareCaptionLabelSeparator{as-Babel-french}{\space\textendash\space}
\captionsetup{margin=0.1\textwidth,labelsep=as-Babel-french}
\captionsetup[table]{position=top}


% Redefinition de l'environnement "thebibliography" afin que son existence soit
% mentionnee a la table des matieres
\newenvironment{thebibliographyUL}[1]%
               {\clearpage%
                \begin{thebibliography}{#1}%
                \addcontentsline{toc}{chapter}{\bibname}%
                \raggedright%
               }%
               {\end{thebibliography}}
               

% En-tete et bas de page par defaut
\pagestyle{headings}


% Definitions pour l'inclusion de graphiques
%    - des repertoires par defaut
%    - des extensions supportees
\graphicspath{{./fig/}}

% Definitions de la page titre
\renewcommand{\maketitle}{%
   \thispagestyle{empty}%
   \pagenumbering{roman}%
   \begin{titlepage}%
      \setcounter{page}{999}%                      % associe le numero "0" a la page titre
      \begin{flushleft}
         \includegraphics[width=12em]{class/ul_logo}
      \end{flushleft}\par
      \begin{flushright}
	\includegraphics[width=12em]{class/Gaul_logo.jpg}
      \end{flushright}
      \vspace*{\stretch{2}}
      \begin{center}
         \parbox{\textwidth}{\centering\Large\bfseries \theTitreProjet}         \\[5ex]
         \parbox{\textwidth}{\centering\large\bfseries \theTitreRapport}        \\
         \vspace*{\stretch{2}}
         \vspace*{\stretch{1}}
         par                                       \\[1ex]
         {\large \theNomEquipe}                \\[1ex]
      \end{center}
      \renewcommand{\arraystretch}{1.5}            % plus d'espace pour les signatures
      \vspace*{\stretch{1}}
      \begin{center}
         {\large Universit\'{e} Laval}             
      \end{center}
   \end{titlepage}%
   \clearpage%
   \let\maketitle\relax%
}


% Definitions des fonctions permettant de definir les parametres de la page titre
%
%\newcommand{\theTitreProjet}{\foreignlanguage{french}{Titre du projet}}                  % Titre du projet
%\newcommand{\TitreProjet}[1]{\renewcommand{\theTitreProjet}{\foreignlanguage{french}{#1}}}           % Titre du projet
\def\TitreProjet#1{\def\theTitreProjet{#1}}           % Titre du projet
\def\TitreRapport#1{\def\theTitreRapport{#1}}         % Titre du rapport
\def\NomEquipe#1{\def\theNomEquipe{#1}}               % Nom de l'equipe
\def\TableauMembres#1{\def\theTableauMembres{#1}}     % Tableau des membres de l'equipe
\def\HistoriqueVersions#1%
   {\def\theHistoriqueVersions{#1}}                   % Historique des versions
 

% Definitions des parametres par defaut de la page titre
\def\theTitreProjet{Titre du projet}                  % Titre du projet
\def\theTitreRapport{Titre du rapport}                % Titre du rapport
\def\theNumeroEquipe{XX}                              % Numero de l'equipe
\def\theNomEquipe{Nom de l'\'{e}quipe}                % Nom de l'equipe
\def\theTableauMembres{matricule & nom & \\\hline}    % Tableau des membres de l'equipe
\def\theHistoriqueVersions%
   {version & date & description \\\hline}            % Historique des versions


% Definition du niveau hierarchique maximum couvert par la table des matieres
\setcounter{tocdepth}{3}            % default = 2

% Definition du niveau hierarchique maximum ayant une numerotation
\setcounter{secnumdepth}{3}         % default = 2

% Definitions des parametres du package hyperref - details propres au rapport
\AtBeginDocument{%
   \hypersetup{pdftitle={\theTitreProjet},%
               pdfsubject={\theTitreRapport},%
               pdfauthor={\'{E}quipe \theNumeroEquipe\ - \theNomEquipe}}%
}

% Selection de la langue "babel" par defaut
\AtBeginDocument{%
   \selectlanguage{french}%
}

% Changement des mots utilises par "babel" par defaut (figure et table)
\AtBeginDocument{%
   \renewcommand{\figurename}{\textsc{Figure}}%
   \renewcommand{\tablename}{\textsc{Tableau}}%
}

% Generation de la page titre
\AtBeginDocument{%
   \maketitle
}


% Generation de la table des matieres, de la liste des figures, de la liste des tableaux
\AtBeginDocument{%
   \tableofcontents
   \ifthenelse{\boolean{InsererListeDesFigures}}%
              {\clearpage%
               \listoffigures%
               \addcontentsline{toc}{chapter}{\listfigurename}}{}
   \ifthenelse{\boolean{InsererListeDesTableaux}}%
              {\clearpage%
               \listoftables%
               \addcontentsline{toc}{chapter}{\listtablename}}{}
}

% Reinitialisation du compteur "page" (valeur et style)
\AtBeginDocument{%
   \cleardoublepage%
   \setcounter{page}{1}%
   \pagenumbering{arabic}%
}
