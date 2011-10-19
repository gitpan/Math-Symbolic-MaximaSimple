use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Math::Symbolic::MaximaSimple',
    AUTHOR              => q{J.Joao Almeida <jj@di.uminho.pt>},
    VERSION_FROM        => 'lib/Math/Symbolic/MaximaSimple.pm',
    ABSTRACT_FROM       => 'lib/Math/Symbolic/MaximaSimple.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Math-Symbolic-MaximaSimple-*' },
);
