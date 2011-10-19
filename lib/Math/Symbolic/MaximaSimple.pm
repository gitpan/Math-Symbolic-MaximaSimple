package Math::Symbolic::MaximaSimple;

use parent qw{Exporter};
our %EXPORT_TAGS=(
  tex => [ qw{ &maxima_tex } ],
  maxima => [ qw{ &maxima } ],
);

our @EXPORT_OK=  map {ref($_) ? (@$_):()}  values %EXPORT_TAGS ;

$EXPORT_TAGS{all}= \@EXPORT_OK;

use warnings;
use strict;
our $VERSION = '0.01';

our $N=333333333333;
use IPC::Open2;

my $pid;
my $R;
my $W;

#INIT {
# startmaxima();
#}

sub startmaxima{
  $SIG{"INT" }=\&_K;
  $pid = open2($R,$W,"maxima ---very-quiet") || die("can open2 maxima\n");
  print $W 'display2d:false$';
  print $W "\n$N;\n";
  my $a=<$R>;
  while($a !~ /^\(\%o\d+\)\s*$N/){ $a = <$R>;}
}

#while(<>) {
#  chomp;
#  next unless /\S/;
#  print "maxima-- ",maxima($_), "\n";
#  print "maxima tex-- ",maxima_tex($_), "\n";
#  print "maxima tex1-- ",maxima_tex1($_), "\n";
#  print "maxima tex2-- ",maxima_tex2($_), "\n";
#}

sub _maxima_tex1{
  my $exp=shift;
  print $W "tex1($exp);\n$N;\n";
  my $a=<$R>;
  my $b="";
  while($a !~ /^\(\%o\d+\)\s*$N/){ 
    $b .= $a;
    $a = <$R>;}
  _clean($b);
}

sub _maxima_tex2{
  my $exp=shift;
  print $W "tex($exp);\n$N;\n";
  #print $W "tex($exp)\$;\n$N;\n";
  my $a=<$R>;
  my $b="";
  while($a !~ /^\(\%o\d+\)\s*$N/){ 
    $b .= $a;
    $a = <$R>;}
  _clean2($b,nomathenv=>1);
}

sub maxima_tex{
  my $exp=shift;
  print $W "tex($exp);\n$N;\n";
  #print $W "tex($exp)\$;\n$N;\n";
  my $a=<$R>;
  my $b="";
  while($a !~ /^\(\%o\d+\)\s*$N/){ 
    $b .= $a;
    $a = <$R>;}
  _clean2($b);
}

sub maxima{
  my $exp=shift;
  print $W "$exp;\n$N;\n";
  my $a=<$R>;
  my $b="";
  while($a !~ /^\(\%o\d+\)\s*$N/){ $b .= $a;
    $a = <$R>;}
  _clean($b);
}

sub _clean2{my ($b,%a)=@_;
  $b =~ s/\(%i\d+\)\s*//g;
  $b =~ s/\s*$//;
  if($b =~ s/\s*\(\%o\d+\)\s*false\s*//){ 
    if($a{nomathenv}){ $b =~ s/^\$\$(.*)\$\$$/$1/; 
          $b }
    else{ $b }
  }
  else                               { [$b]}
}

sub _clean{my $b=shift;
  $b =~ s/\(%i\d+\)\s*//g;
  $b =~ s/\s*$//;
  if($b =~ s/\(\%o\d+\)\s*//){ $b  }
  else                       { [$b]}
}

sub _K {print "END\n\n"; kill(9,$pid); exit 1; }

## END{ _K();}

1; # End of Math::Symbolic::MaximaSimple

=head1 NAME

Math::Symbolic::MaximaSimple - The great new Math::Symbolic::MaximaSimple!

=head1 VERSION

Version 0.01

=head1 SYNOPSIS

    use Math::Symbolic::MaximaSimple;

    my $foo = Math::Symbolic::MaximaSimple->new();

=head1 EXPORT

=head1 SUBROUTINES/METHODS

=head2 startmaxima

=head2 maxima_tex

=head2 maxima


=head1 AUTHOR

J.Joao Almeida, C<< <jj at di.uminho.pt> >>

=head1 ACKNOWLEDGEMENTS

=head1 LICENSE AND COPYRIGHT

Copyright 2011 J.Joao Almeida.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

