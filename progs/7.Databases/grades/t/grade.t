use strict;
use warnings;

use Test::More tests => 8;
use Test::DBIx::Class;

use Local::Schema::Result::Grade;
use DDP;


my $student_rs  = Schema->resultset('Student');
my $teacher_rs  = Schema->resultset('Teacher');
my $grade_rs    = Schema->resultset('Grade');
my $homework_rs = Schema->resultset('Homework');

my $student1 = $student_rs->create({});
my $student2 = $student_rs->create({});
my $student3 = $student_rs->create({});
my $student4 = $student_rs->create({});
my $student5 = $student_rs->create({});

my $teacher = $teacher_rs->create({});
my $homework1 = $homework_rs->create({name => 'A', max_points => 10});
my $homework2 = $homework_rs->create({name => 'B', max_points => 10});

my $grade4 = $grade_rs->create({
    homework => $homework1,
    student  => $student4,
    teacher  => $teacher,
    points   => 8,
});

my $grade1 = $grade_rs->create({
    homework => $homework1,
    student  => $student1,
    teacher  => $teacher,
    points   => 2,
});

my $grade3 = $grade_rs->create({
    homework => $homework1,
    student  => $student3,
    teacher  => $teacher,
    points   => 6,
});

my $grade2 = $grade_rs->create({
    homework => $homework1,
    student  => $student2,
    teacher  => $teacher,
    points   => 4,
});

my $grade5 = $grade_rs->create({
    homework => $homework1,
    student  => $student5,
    teacher  => $teacher,
    points   => 10,
});

my $grade6 = $grade_rs->create({
    homework => $homework2,
    student  => $student5,
    teacher  => $teacher,
    points   => 0,
});
use DDP;

my @better_points1 = $grade1->better_grades()->all();
is(scalar @better_points1, 4, 'Have 4 better points');
is($better_points1[1]->points, 8, 'Is sorted');
my @better_points2 = $grade5->better_grades()->all();
is(scalar @better_points2, 0, 'The best point');
my @better_points3 = $grade6->better_grades()->all();
is(scalar @better_points3, 0, 'No more points');

my @top_five = $grade_rs->top_five_grades($homework1);
is(scalar @top_five, 5, 'all 5 homeworks');
is($top_five[0]->points, 10, 'correct top homework');
@top_five = $grade_rs->top_five_grades($homework2);
is(scalar @top_five, 1, 'all 1 homework');
is($top_five[0]->points, 0, 'correct top homework');
