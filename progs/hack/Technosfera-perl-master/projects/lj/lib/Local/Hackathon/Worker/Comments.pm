package Local::Hackathon::Worker::Comments;
 
use utf8;
 
use warnings;
use strict;
 
use Mouse::Role;
use Mojo::DOM;
 
has '+source',       default => 'comments';
has '+destination',  default => 'commentsinfo';
 
 
sub process {
 
        my $data;
        my ($self, $task) = @_;
        my $html = $task->{'HTML'};
 
        if (not $html) {
                warn 'Error!';
                return $task;
        }
 
        my $dom = Mojo::DOM->new($html);
 
 
 
        my @arr_comments = $dom->find('div[class="comment-wrap"]')->each;
        my @answer;
 
        for my $comment (@arr_comments) {
                my $string;
                $string .= $comment->find('*[class="i-ljuser-username"]')->first;
                $string .= $comment->find('div[class="comment-text"]')->first;
                push @answer, $string;
        }
        push @answer, "please work!";
    $task->{'comments'} = \@answer;
        return $task;
}
 
 
 
1;