# postgresPod=$1
postgresPod=$(kubectl get pods -l app=postgres -o=jsonpath='{.items[].metadata}' | jq -r '.name')

cat test/10-create-user-and-dbs.sql | kubectl exec -i $postgresPod -- psql -U postgres -d postgres
cat test/flights.dump.sql           | kubectl exec -i $postgresPod -- psql -U program flights
cat test/privileges.dump.sql        | kubectl exec -i $postgresPod -- psql -U program privileges
cat test/tickets.dump.sql           | kubectl exec -i $postgresPod -- psql -U program tickets 