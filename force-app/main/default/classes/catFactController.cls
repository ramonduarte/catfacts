public with sharing class catFactController {
    public catFactController() {
    }

    @AuraEnabled(cacheable=true)
    public static String getCatFact() {
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://catfact.ninja/fact');
        req.setMethod('GET');

        Http http = new Http();
        HttpResponse res = http.send(req);

        if (res.getStatusCode() == 200) {
            Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
            return String.valueOf(result.get('fact'));
        } else {
            throw new CalloutException('Failed to retrieve cat fact: ' + res.getBody());
        }
    }
}