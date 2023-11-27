resource -> ETCD <- controller (monitor, change)

# YAML file for a custom resource definition
apiVersion: apiextensions.k8s.io/v1 
kind: CustomResourceDefinition 
metadata: 
    name: flighttickets.flights.com 
spec: 
    scope: Namespaced 
    group: flights.com 
    names:
        kind: FlightTicket # the one you'll use in "kind"
        singular: flightticket 
        plural: flighttickets 
        shortNames:
        - ft 
    versions:
    - name: v1 
      service: true
      storage: true
    schema: 
        openAPIV3Schema:
            <schema>
