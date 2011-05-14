package NoPasta::Web::C::Root;
use strict;
use SQL::Maker;
use Log::Minimal;

my $sqlmaker = SQL::Maker->new( driver => 'SQLite' );

sub index {
    my($class, $c) = @_;

    my($sql, @binds) = $sqlmaker->select(
        'entry',
        ['*'],
        { },
        { limit => 10, order_by => 'entry_id DESC' },
    );
    debugf 'index: %s', $sql;

    $c->dbh->{FetchHashKeyName} = 'NAME_lc';
    my $sth = $c->dbh->prepare($sql);
    $sth->execute();
    my @entries;
    while(my $row = $sth->fetchrow_hashref()) {
        push @entries, $row;

        debugf 'entry: %s', $row;
    }
    return $c->render(
        "index.tt" => { entries => \@entries },
    );
}

sub post {
    my($class, $c) = @_;

    if(my $body = $c->req->body_parameters->{body}) {
        my($sql, @binds) = $sqlmaker->insert(
            'entry',
            { body => $body },
        );
        debugf 'post: %s (%s)', $sql, \@binds;
        my $sth = $c->dbh->prepare($sql);
        $sth->execute(@binds);
    }
    return $c->redirect('/');
}

1;
