#
# My infra aliases and functions
#

queryDns() {
  local query_ns=$(dig @8.8.8.8 $argv ns +short | head -n1)
  echo "querying: $query_ns for domain: $argv"
  dig +noall +answer A $argv @$query_ns
  dig +noall +answer TXT $argv @$query_ns
  dig +noall +answer MX $argv @$query_ns
  dig +noall +answer SOA $argv @$query_ns
}
