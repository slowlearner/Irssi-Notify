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
    $from = add_slashes($from);
    $msg = add_slashes($msg);
    system("notify-send \"$from\" \"$msg\"");
}

sub event_privmsg {
    my ($server, $data, $nick, $address) = @_;
    my $own_nick = $server->{nick};
    
    if($data =~ /$own_nick/i && $data =~ /^(.*?):(.*)/) {
        my($source, $msg) = split(':', $data, 2);
        send_gnome_notification($source,  "[$nick] $msg");
    }
}

sub add_slashes {
    my($text) = shift;
    $text =~ s/\\/\\\\/g;
    $text =~ s/"/\\"/g;
    $text =~ s/\\0/\\\\0/g;
    return $text;
}
Irssi::signal_add("event privmsg", "event_privmsg")
