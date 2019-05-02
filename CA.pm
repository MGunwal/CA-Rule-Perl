package CA;

use strict;
use warnings;
use Data::Dumper;

sub new {
    my ($class,$args) = @_;
    my $self = {
        cells_count => $args->{cells_count} || undef,
        rule_num => $args->{rule_num} || undef
    };
    bless $self, $class;
    return $self;
}

#build_rule_set : create rule set for a given rule number
sub build_rule_set {
    my ($self) = @_;
    my @rule_set = ();
    my $rule_num = int($self->{rule_num});
    my $binary = sprintf ("%b",$rule_num);
    my @bits = split("",$binary);

    for(my $i = $#bits; $i >= 0; $i--){
        push(@rule_set, int($bits[$i]));
    }

    #padding to fill remaining bits
    for(my $i = scalar(@rule_set); $i < 8; $i++){
        push(@rule_set, 0);
    }

    return \@rule_set;
}

#init_row : create first row of CA pattern
sub init_row {
    my ($self,$args) = @_;
    my @arr = ();

    my $cells_count = $self->{cells_count};
    for (my $i = 0; $i < $cells_count; $i++ ){
        $arr[$i] = 0;
    }

    $arr[$cells_count/2] = 1;
    return \@arr;
   
}

#generate : create rows of CA pattern
#   input - recent_row (last updated row)
sub generate {
    my ($self,$args) = @_;
    
    my @next_gen = ();
    my @rule_set = @{$self->{rule_set}};    
    my @temp_arr = @{$args->{recent_row}};

    for(my $i=0; $i < $self->{cells_count}; $i++){
        my $x = $i > 0 ? $temp_arr[$i-1] : 0;
        my $y = $temp_arr[$i];
        my $z = $i < ($self->{cells_count} - 1) ? $temp_arr[$i+1] : 0;
        my $rule_index = 4*$x + 2*$y + $z;
        $next_gen[$i] = $rule_set[$rule_index];       
    }

    return \@next_gen;
}

1;
