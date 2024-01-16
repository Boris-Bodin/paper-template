%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Scub LaTeX Template - SCUB CLASS FILE
%
% This is the main class file of the template
% It define the document class,
% the main packages and the main commands,
% the main layout, the table of contents,
% the header and the footer, the title page,
% the cartouche of authors and versions,
% and the sections and subsections titles.
%
% Created by Boris Bodin
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NeedsTeXFormat{LaTeX2e}[2021-11-15]
\ProvidesClass{archi}[2023/08/28, v0.1]
\newif\if@themeexterne
\@themeexternefalse
\newif\if@themearticle
\@themearticlefalse

\PassOptionsToClass{a4paper}{article}
\PassOptionsToClass{10pt}{article}
\PassOptionsToClass{oneside}{article}
\DeclareOption{externe}{\@themeexternetrue}
\DeclareOption{article}{\@themearticletrue}
\ProcessOptions\relax
\LoadClass{article}

\RequirePackage[immediate]{silence}
\WarningFilter[temp]{latex}{Command \underbar  has changed.}
\WarningFilter[temp]{latex}{Command \underline  has changed.}

\RequirePackage{setspace}
\onehalfspacing
\setlength{\parindent}{0pt}
\setlength{\parskip}{2.0ex plus0.5ex minus0.2ex}

\RequirePackage[utf8]{inputenc}
\RequirePackage[utf8]{inputenx}
\input{ix-utf8enc.dfu}

\RequirePackage[sfdefault]{roboto}
\RequirePackage[french]{babel}
\RequirePackage[T1]{fontenc}
\RequirePackage{lmodern}
\RequirePackage{lastpage}

\RequirePackage{graphicx}
\graphicspath{{assets}{Figures/}{./}}

\RequirePackage[usenames, dvipsnames]{xcolor}
\definecolor{blueScub}{HTML}{365f91}
\definecolor{lightBlueScub}{HTML}{366091}

\RequirePackage{tabularx}
\RequirePackage{multirow}
\RequirePackage{etoolbox}
\RequirePackage{forloop}
\RequirePackage{titletoc}
\RequirePackage{sectsty}
\RequirePackage{ifthen}
\RequirePackage{calc}
\RequirePackage{amsmath, amsfonts, amssymb}
\RequirePackage{enumitem}
\RequirePackage{subcaption}
\RequirePackage{float}
\RequirePackage{booktabs}

\setlength{\abovecaptionskip}{3pt}
\setlength{\belowcaptionskip}{0pt}

%\RequirePackage[pdfpagemode={UseOutlines},bookmarks=true,bookmarksopen=true,
%    bookmarksopenlevel=0,bookmarksnumbered=true,hypertexnames=false,
%    colorlinks,linkcolor={blue},citecolor={blue},urlcolor={red},
%    pdfstartview={FitV},unicode,breaklinks=true]{hyperref}

\if@themearticle
\RequirePackage[
    left=2cm,
    right=2cm,
    top=2.25cm,
    bottom=2.25cm,
    headheight=11pt,
    letterpaper,
]{geometry}
\else
\RequirePackage[%
    margin=15mm,
    top=40mm,
    bottom=25mm,
    headheight=25mm,
    headsep=10mm,
    marginparsep=5mm,
    marginparwidth=5mm,
    footskip=\dimexpr\headsep+\ht\strutbox\relax,
    bmargin = \dimexpr17mm+2\ht\strutbox\relax,
%    showframe
]{geometry}
\fi

\RequirePackage[
    labelfont={bf,sf,small},
    labelsep=period,
    justification=raggedright,
]{caption}

\RequirePackage{readfile}
\RequirePackage{getenv}

\AtEndOfClass{\RequirePackage{microtype}}

\flushbottom % Makes all text pages the same height


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Author
% Sample :
% \addauthor{Boris Bodin}{Lead Dev, Architecte}
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcounter{counterAuthor}
\newcommand\authorName[1]{%
    \csuse{authorName#1}
}
\newcommand\authorQuality[1]{%
    \csuse{authorQuality#1}
}
\newcommand{\addauthor}[2]{
    \stepcounter{counterAuthor}
    \csdef{authorName\thecounterAuthor}{#1}
    \csdef{authorQuality\thecounterAuthor}{#2}
}


\newcount\@authcnt
\newcount\@tmpcnt\@tmpcnt\z@

\def\@affiliation{%
    \ifnum\@tmpcnt<\@authcnt
    \global\advance\@tmpcnt1
    \raggedright \csname @auth\romannumeral\the\@tmpcnt\endcsname\hfill\\%
    \let\next\@affiliation \vskip1pt
    \else
    \let\next\relax
    \fi
    \next%
}

\newcommand{\affiliation}[1]{%
    \global\advance\@authcnt1
    \expandafter\gdef\csname @auth\romannumeral\the\@authcnt\endcsname
    {#1}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Version
% Sample :
% \addversion{0.1}{27/07/2023}{Initialisation du document}
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcounter{counterVersion}
\newcommand\versionNumber[1]{%
    \csuse{versionNumber#1}
}
\newcommand\versionDate[1]{%
    \csuse{versionDate#1}
}
\newcommand\versionLabel[1]{%
    \csuse{versionLabel#1}
}
\newcommand{\addversion}[3]{
    \lastVersion{#1}
    \stepcounter{counterVersion}
    \csdef{versionNumber\thecounterVersion}{#1}
    \csdef{versionDate\thecounterVersion}{#2}
    \csdef{versionLabel\thecounterVersion}{#3}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Paper informations
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\PaperTitle}[1]{\gdef\@PaperTitle{#1}}
\newcommand{\Archive}[1]{\gdef\@Archive{#1}}
\newcommand{\Authors}[1]{\gdef\@Authors{#1}}
\newcommand{\JournalInfo}[1]{\gdef\@JournalInfo{#1}}
\newcommand{\Abstract}[1]{\gdef\@Abstract{#1}}
\newcommand{\Keywords}[1]{\gdef\@Keywords{#1}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Title
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\if@themearticle

\renewcommand{\@maketitle}{%
    \twocolumn[{%
        \thispagestyle{empty}%
        \vskip-36pt%
            {\raggedleft\small\sffamily\bfseries\@JournalInfo\\\@Archive\par}%
        \vskip20pt%
            {\raggedright\color{color1}\sffamily\bfseries\fontsize{20}{25}\selectfont \@PaperTitle\par}%
        \vskip10pt%
            {\raggedright\color{color1}\sffamily\fontsize{12}{16}\selectfont \@Authors\par}%
        \vskip18pt%
        \fcolorbox{color1}{white}{%
            \parbox{\textwidth-2\fboxsep-2\fboxrule}{\centering%
            \colorbox{color2!10}{%
                \parbox{\textwidth-4\fboxsep-2\fboxrule}{%
                    \ifx\@Keywords\@empty%
                    \sffamily\textbf{\abstractname}\\\@Abstract%
                    \else%
                    \sffamily\textbf{\abstractname}\\\@Abstract\\[4pt]%
                    \textbf{\keywordname}\\\@Keywords%
                    \fi%
                }%
            }%
            \vskip4pt%
            \begingroup%
            \raggedright\sffamily\small%
            \footnotesize\@affiliation\par%
            \endgroup%%
            }%
        }%
        \vskip25pt%
    }]%
}
\else
\renewcommand\maketitle{
    \thispagestyle{empty}
    \begin{titlepage}
        \begin{center}
            \vspace*{20pt}
            \includegraphics[width=0.3\textwidth]{logo}\par
            \vspace*{100pt}
            \fontsize{36pt}{36pt}\color{blueScub}\bfseries\MakeUppercase\@title
        \end{center}
    \end{titlepage}
}
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Header / Footer
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


\RequirePackage[page]{totalcount}
\RequirePackage{fancyhdr}
\newcommand{\lastVersion}[1]{\gdef\@lastVersion{#1}}
\newcommand{\headerTitle}[1]{\gdef\@headerTitle{#1}}

\fancyhf{}

\if@themearticle
\fancyhead[R]{
    \small\sffamily\bfseries\@headerTitle\ --- \thepage/\pageref{LastPage}
}
\fi

\if@themeexterne
\fancyhead[C]{
    \renewcommand{\arraystretch}{2}
    \begin{tabularx}{\textwidth}{|@{\hskip6pt}m{42pt}|XcX|c|@{\hskip0pt}m{48pt}|}
        \hline
        \multirow{2}{*}{\includegraphics[width=42pt]{logo}} & & \multirow{2}{*}{\textbf{\@headerTitle}} &  & V\@lastVersion &  \\ \cline{5-5}
        & &                                         & & \thepage/\pageref{LastPage} & \\
    \end{tabularx}%
}
\fancyfoot[C]{
    \renewcommand{\arraystretch}{2}
    \begin{tabularx}{\textwidth}{|c|XcX|c|}
        \hline
        Date de création & & & & Version       \\
        \versionDate{1}  & & & & \@lastVersion \\
        \hline
    \end{tabularx}%
}
\fi

\pagestyle{fancy}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Cartouche
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand\makecartouche{
    \if@themearticle
    \else
    \stepcounter{counterAuthor}
    \newcounter{it}
    \setcounter{it}{0}
    \begin{table}[h]
        \centering
        \renewcommand{\arraystretch}{2}
        \begin{tabularx}{\linewidth}{|l|X|}
            \hline
            \textbf{Auteurs}    & \textbf{Qualités}      \\ \hline
            \forloop{it}{1}{\value{it} < \value{counterAuthor}}{%
                \authorName{\theit} & \authorQuality{\theit} \\ \hline
            }
            &                        \\ \hline
        \end{tabularx}%
    \end{table}
    \vspace{50pt}
    \stepcounter{counterVersion}
    \setcounter{it}{0}
    \begin{table}[h]
        \centering
        \renewcommand{\arraystretch}{2}
        \begin{tabularx}{\textwidth}{|l|c|X|}
            \hline
            \textbf{Version}       & \textbf{Date}        & \textbf{Contenu}      \\ \hline
            \forloop{it}{1}{\value{it} < \value{counterVersion}}{%
                \versionNumber{\theit} & \versionDate{\theit} & \versionLabel{\theit} \\ \hline
            }
            &                      &                       \\ \hline
        \end{tabularx}%
    \end{table}
    \clearpage
    \fi
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Table of contents
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newlength{\tocsep}
\setlength\tocsep{1.5pc} % Sets the indentation of the sections in the table of contents

\renewcommand\tableofcontents{
    \singlespacing
    \@starttoc{toc}
    \onehalfspacing
    \clearpage
}
\setcounter{tocdepth}{3}

\if@themearticle
\contentsmargin{0cm}

\titlecontents{section}[\tocsep]
{\addvspace{4pt}\small\bfseries\sffamily}
{\contentslabel[\thecontentslabel]{\tocsep}}
{}
{\hfill\thecontentspage}
[]

\titlecontents{subsection}[\tocsep]
{\addvspace{2pt}\sffamily}
{\contentslabel[\thecontentslabel]{\tocsep}}
{}
{\ \titlerule*[.5pc]{.}\ \thecontentspage}
[]

\titlecontents*{subsubsection}[\tocsep]
{\footnotesize\sffamily}
{}
{}
{}
[\ \textbullet\ ]

\else

\titlecontents{section}[0pt]
{\vskip 5pt \thecontentslabel \quad}
{\bfseries}
{\bfseries}
{\bfseries\dotfill\contentspage}

\titlecontents{subsection}[0pt]
{\hspace{20pt} \thecontentslabel \quad}
{}
{}
{\dotfill\contentspage}

\titlecontents{subsubsection}[0pt]
{\hspace{40pt} \thecontentslabel \quad}
{}
{}
{\dotfill\contentspage}

\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Section Title
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\if@themearticle

\RequirePackage[explicit]{titlesec}

\titleformat{\section}
{\color{color1}\large\sffamily\bfseries}
{}
{0em}
{\colorbox{color2!10}{\parbox{\dimexpr\linewidth-2\fboxsep\relax}{\centering\thesection.\space#1}}}
[]

\titleformat{name=\section,numberless}
{\color{color1}\large\sffamily\bfseries}
{}
{0em}
{\colorbox{color2!10}{\parbox{\dimexpr\linewidth-2\fboxsep\relax}{\centering#1}}}
[]

\titleformat{\subsection}
{\color{color1}\sffamily\bfseries}
{\thesubsection}
{0.5em}
{#1}
[]

\titleformat{\subsubsection}
{\sffamily\small\bfseries}
{\thesubsubsection}
{0.5em}
{#1}
[]

\titleformat{\paragraph}[runin]
{\sffamily\small\bfseries}
{}
{0em}
{#1}

\titlespacing*{\section}{0pc}{3ex \@plus4pt \@minus3pt}{5pt}
\titlespacing*{\subsection}{0pc}{2.5ex \@plus3pt \@minus2pt}{0pt}
\titlespacing*{\subsubsection}{0pc}{2ex \@plus2.5pt \@minus1.5pt}{0pt}
\titlespacing*{\paragraph}{0pc}{1.5ex \@plus2pt \@minus1pt}{10pt}

\else

\sectionfont{\fontsize{20pt}{20pt}\color{blueScub}}
\subsectionfont{\hspace{20px}\normalfont\fontsize{16pt}{16pt}\color{lightBlueScub}}
\subsubsectionfont{\hspace{40px}\normalfont\fontsize{14pt}{14pt}\color{lightBlueScub}}

\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Figure
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newenvironment{centerfigure}{\figure[H]\centering}{\endfigure}

\newenvironment{centerfigurenewpage}{\newpage\vfill\centerfigure}{\endcenterfigure\vfill\clearpage}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% References
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\renewcommand{\@biblabel}[1]{\bfseries\color{color1}\textsuperscript{[#1]}} % Styling of the reference numbers in the bibliography
%\setlength{\bibitemsep}{0cm}

\newcommand{\oldbibliography}{\thebibliography}

\renewcommand{\thebibliography}[1]{%
    \addcontentsline{toc}{section}{\refname}%
    \oldbibliography{#1}%
    \setlength\itemsep{0pt}%
}
