\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ama}[2025 AMA]

\RequirePackage[utf8]{inputenc}

% Load base class with options
\LoadClass[%
    a4paper,
    fontsize=10pt,
    twocolumn=true,
    DIV=13,
    captions=tableheading
]{scrartcl}

% Document title macros
\newcommand*{\@topic}{}
\newcommand*{\topic}[1]{\gdef\@topic{#1}}
\newcommand*{\@email}{}
\newcommand*{\email}[1]{\gdef\@email{#1}}
\newcommand*{\@abstract}{}
\renewcommand*{\abstract}[1]{\gdef\@abstract{#1}}
\newcommand*{\@keywords}{}
\newcommand*{\keywords}[1]{\gdef\@keywords{#1}}

% Loading packages
\RequirePackage[T1]{fontenc}
\RequirePackage[UKenglish]{babel}
\RequirePackage[nopatch=eqnum]{microtype}
\RequirePackage{authblk}
\RequirePackage[%
    backend=biber,
    style=numeric,
    giveninits=true,
    natbib=true,
    hyperref=true,
    sorting=none
]{biblatex}
\RequirePackage{csquotes}
\RequirePackage{booktabs}
\RequirePackage{amsmath}
\RequirePackage{siunitx}
\RequirePackage[hidelinks]{hyperref}

% Font style and selection
\renewcommand{\familydefault}{\sfdefault}
\frenchspacing
\renewcommand\Authfont{\itshape}
\renewcommand\Affilfont{\itshape}
\urlstyle{same}

% Page layout and style
\setlength\columnsep{8mm}
\pagestyle{empty}
\renewcommand{\floatpagefraction}{0.9}

% Modifications to author block
\renewcommand\AB@authnote[1]{\hspace{0.12em}{\normalfont{\textsuperscript{#1}}}}

% Section header style
\RedeclareSectionCommand[
    afterindent=false,
    beforeskip=.5\baselineskip plus .5\baselineskip,
    afterskip=.1\baselineskip,
    font=\normalsize
]{section}
\setcounter{secnumdepth}{0}

% Disable subsection, subsubsections and paragraphs
\renewcommand{\subsection}{%
    \ClassError{AMA}{Subsections are not available}{%
        Please only use sections to structure your document.%
    }%
}
\renewcommand{\subsubsection}{%
    \ClassError{AMA}{Subsubsections are not available}{%
        Please only use sections to structure your document.%
    }%
}
\renewcommand{\paragraph}{%
    \ClassError{AMA}{Paragraphs are not available}{%
        Please only use sections to structure your document.%
    }%
}

% Caption style
\setcapindent{0mm}
\setkomafont{captionlabel}{\itshape}
\setkomafont{caption}{\itshape}
\renewcaptionname{UKenglish}{\figurename}{Fig.}
\renewcaptionname{UKenglish}{\tablename}{Tab.}

% Equation reference style (always use parenthesis)
\renewcommand{\tagform@}[1]{\maketag@@@{\ignorespaces#1\unskip\@@italiccorr}}
\let\orgtheequation\theequation
\renewcommand{\theequation}{(\orgtheequation)}

% Automatic referencing labels (always abbreviate)
\renewcaptionname{UKenglish}{\equationautorefname}{Eq.}
\renewcaptionname{UKenglish}{\figureautorefname}{Fig.}
\renewcaptionname{UKenglish}{\tableautorefname}{Tab.}

% Modifications to reference style
\DeclareFieldFormat{doi}{
    DOI\addcolon\space\href{https://doi.org/#1}{\nolinkurl{#1}}
}
\DeclareFieldFormat{url}{
    URL\addcolon\space\url{#1}
}

% Automatically place document title, authors, abstract, etc.
\AddToHook{begindocument/end}{%
    \twocolumn[%
        \vspace{-10mm}
        {\color{gray}\fbox{\begin{minipage}[c]{0.33\linewidth}
            \large Topic: \@topic
        \end{minipage}}}
        \hfill
        {\begin{minipage}[c]{0.33\linewidth}
            \raggedleft
            \includegraphics[width=\linewidth]{graphics/logo.pdf}
        \end{minipage}}
        \vspace{10mm}

        \centerline{\begin{minipage}{0.85\linewidth}
            \begin{center}
                {\Large\bfseries\@title\par}
                \vspace{4mm}
                \AB@authlist\par
                \AB@affillist\par
                \@email
            \end{center}

            \textbf{Abstract:} \@abstract\par
            \vspace{2mm}
            \textbf{Keywords:} \@keywords\par
            \vspace{6mm}
        \end{minipage}}
    ]%
}
