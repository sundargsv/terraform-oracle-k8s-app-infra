#!/bin/bash

echo "Setting up port forwarding for PostgreSQL..."
echo "Connect to the database using:"
echo "Host: localhost"
echo "Port: 5432"
echo "Database: myapp"
echo "Username: dev"
echo "Password: admin"
echo ""
echo "Press Ctrl+C to stop port forwarding"
echo ""

kubectl port-forward -n postgresql svc/postgresql-postgresql 5432:5432 