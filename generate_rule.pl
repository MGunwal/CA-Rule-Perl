#!/usr/bin/perl -w

use strict;
use Getopt::Long qw(GetOptions);
use IO::Select;

use CA;

my $start = 0;         # trigger to start automata
my $cells_count = 100;  # default cells_count/width
my $rule_num = 30 ;   # default rule number
my $recent_row = [];

GetOptions(

    'start|s' => \$start,
    'rule|r=s' => \$rule_num,
    'width|w=s' => \$cells_count
);

MAIN : {
    print "Rule : Rule$rule_num , Cells_count/Width : $cells_count \n";    
    if($start){
        my $s = IO::Select->new();
        $s->add(\*STDIN);

        my $CA = CA->new({cells_count => $cells_count, rule_num => $rule_num});
        $CA->{rule_set} =  $CA->build_rule_set();
        
        $recent_row = $CA->init_row();
        print_state($recent_row);
        
        my $stop = 0;
        
        while(!$stop){
            $recent_row = $CA->generate({recent_row => $recent_row});
            print_state($recent_row);

            $stop = 1 if($s->can_read(.2));
        }   
    }

}

# Print row of cells ( . for dead cell, * for live cell)
sub print_state {
    my $row = shift;
    foreach(@$recent_row){
        my $state = ($_ == 1) ? '*' : '.';
        print $state;
    }

    print "\n";
}
