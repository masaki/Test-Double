use inc::Module::Install;

name 'Test-Double';
all_from 'lib/Test/Double.pm';
readme_from 'lib/Test/Double.pm';
readme_pod_from 'lib/Test/Double.pm';

requires 'Exporter';
requires 'Class::Monadic';
requires 'Scalar::Util' => 1.14;

tests 't/*.t t/*/*.t';
test_requires 'Test::More' => 0.96;
test_requires 'Test::Memory::Cycle';

author_tests 'xt';
author_requires 'Test::Pod';
author_requires 'Test::Pod::Coverage';
author_requires 'Test::Spelling';

auto_set_repository;
WriteAll;
