fvm flutter test --coverage
dart run remove_from_coverage -f coverage/lcov.info -r '\.g\.dart$' -r 'main\.dart'
dart pub global activate --source git https://github.com/mrverdant13/coverde.git --git-path=packages/coverde_cli --git-ref=24d3dd8
coverde report --markdown coverage/report.md
