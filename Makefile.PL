use inc::Module::Install;

name 'Test-Double';
license 'perl';
all_from 'lib/Test/Double.pm';
readme_pod_from 'lib/Test/Double.pm';

requires 'Exporter';
requires 'Class::Monadic';
requires 'Scalar::Util' => 1.14;
requires 'Test::Deep';

tests 't/*.t t/*/*.t';
test_requires 'Test::More' => 0.96;
test_requires 'Test::Exception' => 0.31;

author_tests 'xt';

auto_set_repository;
WriteAll;
