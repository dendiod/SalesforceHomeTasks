describe('c:AnimalComponent', function () {
    it('verify mocked server method invocation', function (done) {
        $T.createComponent("c:AnimalComponent", {myText: 'leaves'}, true)
            .then(function (component) {
                var mockResponse = { 
                    getState: function () { 
                        return "SUCCESS";
                    }, 
                    getReturnValue: function () { 
                        return [
                            {"Name": "elephant", "My_Id__c" : "7", "Eats__c" : "leaves", "Says" : "i am elephant"},
                            {"Name": "giraffe", "My_Id__c" : "5", "Eats__c" : "leaves", "Says" : "i am giraffe"} 
                            ];  
                    } 
                };
                spyOn($A, "enqueueAction").and.callFake(function (action) {
                    var cb = action.getCallback("SUCCESS");
                    cb.fn.apply(cb.s, [mockResponse]);
                });
                component.doInit();
                expect(component.get("v.mydata").length).toBe(2);
                expect(component.get("v.mydata")[0]['Name']).toContain("elephant");
                done();
            }).catch(function (e) {
                done.fail(e);
            });
    });

    it('verify ui rendering', function (done) {
        $T.createComponent('c:AnimalComponent', {}, true)
            .then(function(component) {
                expect(component.find("inputText").get("v.value")).toBe('1');
                expect(component.find("actionBtn").get("v.label")).toBe('Search animals');            
                done();
            }).catch(function (e) {
                done.fail(e);
            });
    });
});