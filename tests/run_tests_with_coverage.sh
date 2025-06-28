#!/bin/bash
# Clean previous coverage data
NAME=$(basename $(realpath .))
DOCS=/tmp/"$NAME"_coverage
export COVERAGE_FILE=/tmp/."$NAME"_coverage
echo [$NAME] $DOCS
rm -f "$COVERAGE_FILE"*
rm -rf $DOCS

# Run tests with coverage
python -m coverage run --source $NAME -m pytest tests
python -m coverage report
# Generate HTML report
python -m coverage html --directory="$DOCS" --title="$NAME Coverage Report"
echo "Coverage report generated at: $DOCS/index.html"