component 
    extends="quick.models.BaseEntity"
    accessors="true"
    table="user"
{

    property name="id";
    property name="updatedDate" sqltype="timestamp";
    property name="firstName";
    property name="lastName";
    
    property name="renderer" inject="provider:coldbox:renderer" persistent="false";
    
    
    /**
     * createPdf
     * 
     * @baseUrl
     */
    void function sendEmail( required string baseUrl ) {
        
        var body = renderer.renderView(
            view = "emails/index",
            args = {
                "user": {
                    "id": 1,
                    "firstName": "dave"
                },
                "baseUrl" = baseUrl
            }
        );

        cfmail( 
            to = "recipient@example.com", 
            from = "sender@example.com", 
            subject = "Example email" 
        ) { 
            writeOutput( body ); 
        }

    }


}