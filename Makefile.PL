use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'NoPasta',
    AUTHOR        => 'Fuji, Goro (gfx) <gfuji@cpan.org>',
    VERSION_FROM  => 'lib/NoPasta.pm',
    PREREQ_PM     => {
        'Amon2'                           => '2.34',
        'Text::Xslate'                    => '1.1005',
        'Text::Xslate::Bridge::TT2Like'   => '0.00008',
        'Plack::Middleware::ReverseProxy' => '0.09',
        'Plack::Middleware::Log::Minimal' => '0.04',
        'HTML::FillInForm::Lite'          => '1.09',
        'Time::Piece'                     => '1.20',
        'Data::UUID'                      => '1.217',
        'DBI'                             => '1.6',
        'DBD::SQLite'                     => '1.31',
        'SQL::Maker'                      => '0.14',
        'Amon2::DBI'                      => '0.04',
    },
    MIN_PERL_VERSION => '5.008001',
    (-d 'xt' and $ENV{AUTOMATED_TESTING} || $ENV{RELEASE_TESTING}) ? (
        test => {
            TESTS => 't/*.t xt/*.t',
        },
    ) : (),
);
