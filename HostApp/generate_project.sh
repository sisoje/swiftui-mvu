mise install tuist@4.20.0
mise use tuist@4.20.0
touch dummy.swift
echo "import SwiftUINative; @main extension ViewTestingApp {}" > App.swift
tuist generate --no-open
