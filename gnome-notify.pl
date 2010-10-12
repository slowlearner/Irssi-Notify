use strict;
use vars qw($VERSION %IRSSI);

$VERSION = '1.00';
%IRSSI = (
    authors     => 'Erwin Atuli',
    contact     => 'erwinatuli\@gmail.com',
    name        => 'Gnome Notifier',
    description => 'This script allows forwarding notifications' .
                    'to gnome\'s notification engine',
    license     => 'Public Domain',
);

sub send_gnome_notification {
    my($from, $msg) = @_;
    print $from;
    print $msg;
    system("notify-send \"$from\" \"$msg\"");
}

sub event_privmsg {
    my ($server, $data, $nick, $address) = @_;
    
    #how do i get my own nick????
    my $own_nick = 'slowlearner';
    if($data =~ /.*?$own_nick.*/ &&  $data =~ /^(.*)\s:(.*)/) {
        send_gnome_notification($1, $nick. " said: " .$2);
    }
}
Irssi::signal_add("event privmsg", "event_privmsg")
