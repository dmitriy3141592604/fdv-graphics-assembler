#!/usr/bin/perl
use strict;
use File::Copy ;

my $outputDir ;
my $sourceFileNameWitSourceDir;
my $srcDirectory = "src" ;
my $targetDirectory = "custom-target" ;
my $jarOptions = "cvmf" ;
my $jarFileName = "marker-creator.jar" ;
system("cls");
system("chcp 65001");
system(
("javac", 
"-d", 
$outputDir = "custom-target" ,
$sourceFileNameWitSourceDir = "$srcDirectory\\main\\java\\fdv\\graphics\\assembler\\tools\\regression\\test\\list\\builder\\MarkerCreator.java"
)) && die "fdv: 151374513: Compiling error $?";
print "Compilation SUCCESS\n" ;

my $javaClassPath = $sourceFileNameWitSourceDir ;
$javaClassPath =~ s/^src.main.java.// ;
$javaClassPath =~ s/.java$// ;
$javaClassPath =~ s/\\/./g ;

print "fdv:151374558:java class: $javaClassPath\n" ;
print "Program output:\n" ;
system (( "java", "-classpath", "custom-target", $javaClassPath)) ;
print "fdv::End of program output\n" ;
print "\n" ;
# TODO Можно оформить как map и автоматически выверить ширину
print "srcDirectory      : $srcDirectory\n" ;
print "javaClassPath     : $javaClassPath\n" ;
print "target-directory  : $targetDirectory\n" ;
print "\n" ;
print "Start acrive creating\n" ;
my @jarCommandLine = ( "jar", $jarOptions, "marker-creator-manifest.txt", $jarFileName, "-C", $targetDirectory . "/", ".") ;
print "fdv: jar commandline: ", (join " ", @jarCommandLine), "\n" ;
system @jarCommandLine ; # && die "fdv::При создании архива произошла ошибка: $?" ;


my @toolExecuteCommandLine = ("java", "-jar", "marker-creator.jar") ;
print "marker-creator execution command line: ", (join " ", @toolExecuteCommandLine), "\n" ;
system @toolExecuteCommandLine ;

print "\n" ;
# c:\\wks\\graphics-assembler-workspace\\fdv-graphics-assembler\\tools\\marker-creator

print "Start installing program\n\n" ;
my $perlExecutor =<<PERL_EXECUTOR;
#!/usr/bin/perl
use strict ;
my \$commandLine = "java -jar c:\\\\wks\\\\graphics-assembler-workspace\\\\fdv-graphics-assembler\\\\tools-lib\\\\marker-creator.jar" ;
system \$commandLine ;
PERL_EXECUTOR

print "perl executor content:\n $perlExecutor\n" ;
my $toolsLibDirectory = "c:\\wks\\graphics-assembler-workspace\\fdv-graphics-assembler\\tools-lib" ;
print "copy file $jarFileName to directory: $toolsLibDirectory\n";

#print "\n\nJAR FILE NAME CONTENT\n" ;
#system (("dir", $jarFileName)) ;

#print "\n\nTOOLS LIB DIRECTORY CONTENT\n" ;
#system (("echo", $toolsLibDirectory));
#system (("dir", $toolsLibDirectory));

#print "\nCOPY COMMAND EXECUTION\n" ;
#system (( "copy", $jarFileName, $toolsLibDirectory)) ;

print "\n\n" ;
print "Start creating executor\n" ;
open( EXECUTOR, ">c:\\wks\\graphics-assembler-workspace\\fdv-graphics-assembler\\tools\\marker-creator.pl") or die "@!" ;
print EXECUTOR $perlExecutor ;
print EXECUTOR "\n" ;
close EXECUTOR ;

1;
