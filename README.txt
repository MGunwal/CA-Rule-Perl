This Cellular Automata project contains two files :

generate_rule.pl - script to generate ca pattern on command line
    input options :
        --start ( -s ) : to start the pattern (mandatory)
        --rule ( -r ) : set Rule Number (optional. default is Rule 30)
        --width ( -w ) : number of cells in a row (optional. default - 100)

        Hit ENTER to stop the process

        Example :
            perl generate_rule.pl -s  # create automata for rule 30 (default rule) and cells perl row - 100 (default)
            perl generate_rule.pl -s -r 30
            perl generate_rule.pl -s -r 90 -w 150  # create automata for rule 90 and cells perl row - 150

    dependent packages :
        Getopt::Long
        IO::Select
        CA - (user defined package included in tar file)
