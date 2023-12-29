@isTest
private class CatFactControllerTest {

    @isTest
    static void testGetCatFact() {
        Test.setMock(HttpCalloutMock.class, new MockCatFactHttpResponseGenerator());
        
        // This causes a fake response to be sent
        String res = catFactController.getCatFact();
        
        // // Verify response received contains fake values
        // String contentType = res.getHeader('Content-Type');
        // System.assert(contentType == 'application/json');
        // String actualValue = res.getBody();
        // String expectedValue = '{"example":"test"}';
        // System.assertEquals(actualValue, expectedValue);
        // System.assertEquals(200, res.getStatusCode());

        HttpCalloutMock mock = new CatFactHttpMock();
        Test.setMock(HttpCalloutMock.class, mock);

        // Call the getCatFact method from the controller
        String catFact = catFactController.getCatFact();

        // Verify the result
        System.assertNotEquals(null, catFact);
    }

    // Inner class to mock the HTTP response
    private class CatFactHttpMock implements HttpCalloutMock {
        public HttpResponse respond(HttpRequest req) {
            HttpResponse res = new HttpResponse();
            res.setStatusCode(200);
            res.setBody('{"fact": "test"}');
            return res;
        }
    }
}
