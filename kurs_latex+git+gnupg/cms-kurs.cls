\NeedsTeXFormat{LaTeX2e}[1994/12/01]
\ProvidesClass{cms}[2018/08/07 v1.00 Documentclass for CmS Presentations]

%% Class Options

\RequirePackage{etoolbox}

\newbool{notes}
\boolfalse{notes}
\DeclareOption{notes}{\booltrue{notes}}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{beamer}}

\ProcessOptions\relax

%% General Package Loading

\LoadClass[12pt,xcolor={svgnames,table}]{beamer}

\RequirePackage{graphicx}
\RequirePackage[ngerman]{babel}
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\RequirePackage{tikz}
\RequirePackage{pgfpages}
\RequirePackage{csquotes}
\RequirePackage{comment}
\RequirePackage{ifthen}
\RequirePackage{textcomp}

%% Beamer

%\usetheme{Darmstadt}
\setbeamertemplate{footline}[frame number]
\setbeamertemplate{navigation symbols}{}

%\pgfdeclareimage[height=.6cm]{c3d2logo}{./img/c3d2.pdf}

%\pgfdeclarelayer{foreground}
%\pgfsetlayers{main,foreground}
%\logo{\pgfputat{\pgfxy(-1,0)}{\pgfbox[center,base]{\pgfuseimage{c3d2logo}}}}

\ifbool{notes}{
  \setbeameroption{show notes on second screen = right}}{}

\DeclareRobustCommand{\license}[2][]{\\#2\ifthenelse{\equal{#1}{}}{}{\\\scriptsize\url{#1}}}
\DeclareRobustCommand{\cc}[1]{\includegraphics[height=4mm]{img/#1.png}\hspace{1mm}}

\DeclareRobustCommand{\includedeck}[1]{\include{content/#1}}

%% Listings

\RequirePackage{listings}

\lstset{
  texcl=true,
  commentstyle=\rm,
  basicstyle=\tt,
  numbers=none,
  stepnumber=1,
  firstnumber=0,
  numberstyle={\tiny},
  commentstyle={\itshape},
  columns=fullflexible,
}

\DeclareRobustCommand{\gitcmd}[1]{\lstinline{git #1}}

%% To-Do-Notes

\RequirePackage{todonotes}
\DeclareRobustCommand{\TODO}[1]{\todo[inline]{TODO: #1}}

%% Section and Subsection Headings

\AtBeginSection{{
  \begin{frame}
    \begin{block}{}
      \usebeamercolor[fg]{titlelike}%
      \LARGE\strut\smash{\insertsection}\newline
      \Large\null\hfill\strut\smash{~}
    \end{block}
  \end{frame}
}}

\AtBeginSubsection{{
  \begin{frame}
    \begin{block}{}
      \usebeamercolor[fg]{titlelike}%
      \LARGE\strut\smash{\insertsection}\newline
      \Large\null\hfill\strut\smash{\insertsubsection}
    \end{block}
  \end{frame}
}}

%% TikZ

\usepackage{tikz}
\tikzset{
  commit/.style={draw=green!80!black,fill=green!80!white,circle,very thick},
  pred/.style={<-,very thick,>=stealth}
}