Modifichiamo il prompt con ~/.bashrc

Controllando un pò di siti vengo a conoscenza che per modificare la formattazione del prompt basta

un semplice comando molto personalizzabile digitabile sempre da terminale.

illusion²²:~$ export PS1='\u@:\w>'

che mi modificherà il prompt in questa modo

illusion@~>

Diverse sono le opzioni da poter impostare. Dalle semplici stringhe a caratteri particolari come ” \u ” che è l’utente oppure ” \w ” che è la directory corrente.

Eccone alcune fra le più importanti prese direttamente dal manuale di Bash.

    \d the date in “Weekday Month Date” format (e.g., “Tue May 26″)
    \D{format} the format is passed to strftime(3) and the result is inserted into the prompt string; an empty format results in a locale-specific time representation
    \h the hostname up to the first ‘.’
    \H the hostname
    \j the number of jobs currently managed by the shell
    \l the basename of the shell’s terminal device name
    \s the name of the shell, the basename of $0 (the portion following the final slash)
    \t the current time in 24-hour HH:MM:SS format
    \T the current time in 12-hour HH:MM:SS format
    \@ the current time in 12-hour am/pm format
    \A the current time in 24-hour HH:MM format
    \u the username of the current user
    \v the version of bash (e.g., 2.00)
    \V the release of bash, version + patch level (e.g., 2.00.0)
    \w the current working directory, with $HOME abbreviated with a tilde
    \W the basename of the current working directory, with $HOME abbreviated with a tilde
    \! the history number of this command
    \# the command number of this command
    \$ if the effective UID is 0, a #, otherwise a $
    \\ a backslash
    \[ begin a sequence of non-printing characters, which could be used to embed a terminal control sequence into the prompt
    \] end a sequence of non-printing characters

Una regola da rispettare è che dopo “PS1=” si devono mettere necessariamente la stringa scelta fra due apici come nell’esempio con “export” altrimenti all’apertura della shell darà un errore

Da notare che gli spazi vengono interpretati corramente.

Dopo che avete trovato la vostra opzione configurazione preferita bisogna rendere queste modifiche permanenti e quindi editare il file ~/ .bashrc con nano (io ho usato “nano” ma va benissimo anche vi o gedit o qualunque altro editor di testo)

:~$ nano .bashrc

Se presente qualcosa del genere PS1= ‘\u@\h:\w\$ ‘ commentatela mettendo un # avanti per non essere letta e impostatela come desiderate con la stessa “logica” della riga appena commentata.

Se invece trovate una roba del genere (il mio caso): PS1=’${debian_chroot:+($debian_chroot)}\u@\h:\w\$ ‘ andate tranquilli e fate lo stesso procedimento sopracitato.

Dopo aver sistemato il parametro PS1 salvate il file. Noterete che la shell è identica a prima.

E’ normale. Per vedere il cambiamento aprite una nuova shell oppure digitate nella shell corrente:

:~$ source .bashrc

* Per modificare le impostazioni di tutti gli utenti modificate questo /etc/bash.bashrc invece di ~/.bashrc
E ora coloriamo!

Mentre guardavo il ~/.bashrc mi è capitato di osservare una cosa del genere: “[33[00m\]:”

Essendo poco prima di alcune opzioni di una PS1 commentata rendo effettiva proprio quest’ultima e noto il cambiamento della formattazione anche con colori diversi.

Cerco un pò sul mio amato guuugol. E trovo questa bella robetta:

    BOLD=”\[33[1m\]” –> Grassetto

    UNDERLINE=”\[33[4m\]” –> Sottolineato

    BLACK=”\[33[30m\]” –> Da qui in poi tutti colori

    RED=”\[33[31m\]“

    GREEN=”\[33[32m\]“

    YELLOW=”\[33[33m\]“

    BLUE=”\[33[34m\]“

    MAGENTA=”\[33[35m\]“

    CYAN=”\[33[36m\]“

    WHITE=”\[33[37m\]“

Basta metterlì dopo “PS1=’ ” e il gioco è fatto. Ad esempio se voglio che formattato in grassetto e giallo imposto in questo modo PS1.

PS1=’ \[33[1m\]\[33[33m\]\u@:\w> '
Cè un piccolo problema che mi ha convinto a non usare quest’opzione. Ovvero che non cambia solo la parte “statica” della shell ma tutto il testo che noi scriviamo.
Viva gli alias!

Vi è mai capitato di stare ore e ore sul terminale e di digitare sempre i soliti lunghi comandi che arrivi al punto di sognarli pure la notte?

Bene, a me capita spesso! :-)

Fin da quando ho scoperto linux per la prima volta notai per caso gli “alias”.

Cosa sono lo si può immaginare. Non fanno altro che creare un’alternativa ad un altro comando, o anche più comandi semplificando e riducendo il lavoro di molto.

Per esempio una cosa che mi sono portato dietro da uindos è il “cd..” per andare indietro dalla cartella corrente alla precedente.

illusion²²:~$ cd..
bash: cd..: command not found

Il corrispondente sulla bash è “cd ..” con lo spazio. A dire la verità mi sono abituato da molto tempo al “cd ..” ma ho notato che ogni tanto nella fretta di scrivere, dimenticavo lo spazio o lo digitavo dopo i due punti. Quindi creando un alias, posso usare entrambi i comandi e non avrò più l’errore della shell che mi indica che non trova il comando digitato.

Per aggiungere gli alias (ne troverete alcuni tipo “ll”, “la” come alternative ad “ls”) vi basta modificare come sempre il file .bashrc nella vostra home

:~$ nano .bashrc

Scorrendo verso la fine troverete qualcosa come “some more ls aliases”

Aggiungete lì i vostri alias per non pasticciare il vostro bel bashrc modificato :-)

Ecco i comandi che uso al momento, anche se ne dovrei aggiungere altri:

alias ll='ls -l --color=auto'
alias la='ls -A --color=auto'
alias cd..='cd ..'
alias deb64='sudo dpkg --force-architecture -i'
alias acs='apt-cache search'
alias agu='sudo apt-get update'
alias agg='sudo apt-get upgrade'
alias agd='sudo apt-get dist-upgrade'
alias agi='sudo apt-get install'
alias agr='sudo apt-get remove'
alias up='svn up'
alias ins='./configure && make && sudo make install'
alias insa='./autogen.sh && make && sudo make install'
alias repo='sudo nano /etc/apt/sources.list'
alias xorg='sudo nano /etc/X11/xorg.conf'

Da notare gli ultimi cinque che secondo me sono fondamenatali (ma diciamo un pò tutti…)

    up per aggiornare una cartella che state seguendo con svn, aggiungendo il parametro cartella, oppure senza se siete già dentro.

    ins e insa per configurare, compilare ed installare (senza parametri aggiuntivi) un sorgente che avete appena estratto, rispettivamente con ./configure o autogen.sh in base a come viene proposto

    repo e xorg per modicare con nano l’xorg.conf o il sources.list (potete mettere ovviamente qualunque altro editor)

Le possibilità sono infinite, quindi sbizzarritevi!
Log log log e ancora log!

Piccolo tips ma che può rivelarsi utile. Aumentare il numero di comandi massimi che la shell può ricordarsi che verranno memorizzati nel “.bash_history” (sempre nella home)

Nel vostro .bashrc aggiungete alla fine o modificate (se già esistente) questo semplice codice

HISTSIZE=5000

Questo non fa altro che impostare che la shell deve ricordarsi almeno 5000 comandi per ogni sessione (default 500) ;-)

Cambiate il numero di quanto volete. Alla fine sono pochi kb

Potete anche modificare/aggiungere questi due parametri

HISTFILE (default ~/.bash_history)

Che indica il file che deve essere usato per contenere i comandi digitati.
Se non impostato lo storico si limitera’ alla sessione di lavoro corrente.

HISTFILESIZE (default 500 )
Determina la grandezza massima che puo’ avere il file dello storico.(sempre in numero di comandi)

Se volete vedere tutti i comandi digitati da terminale (potete aprirlo anche da interfaccia grafica eh..:-) )

history

Invece se volete cancellare lo storico da terminale digitate

history -c

Un consiglio: digitate questa comando per gli ultimi comandi digitati

history | tail

e magari aggiungete un alias come ormai sappiamo fare :-)

alias asd='history | tail

Ho messo asd perchè è semplice da ricordare e facile da scrivere(voi mettete quello che volete) :-) 
