#           Alpha version       Beta version        GA version
Enabled     No (enable flags)    Yes(default)       Yes (default)
Tests       lacks e2e test      e2e tests           conformance test 
Reliability  have bugs          minor bugs          highly reliable 
Support       None              commit to GA        will be present 

# API Deprecation policies
1) API ELEMENTS CAN ONLY BE REMOVED BY INCREMENTING VERSION OF API GROUP 
/v1alpha1 --> /v1alpha2 

2) API OBJECTS MUST BE ABLE TO ROUND TRIP BETWEEN API VERSIONS IN A GIVEN RELEASE W/O INFO LOSS
ability to roll back & be compativle with the previous versions 

3) API versions must be supported:
--> GA: 12 months/3 releases 
--> Beta: 9 months/3 releases 
--> Alpha: 0 releases 

4) "preferred" & "storage version" for any API group can not advance until after a release has been made
    that supports both the new version & the previous version 

5) An API version in a track may not be deprecated until a new API version is at least stable 

# How to convert apiVersions? 
k convert -f <old-file> --output-version <new-api>
k convert -f nginx.yaml --output-version apps/v1 



