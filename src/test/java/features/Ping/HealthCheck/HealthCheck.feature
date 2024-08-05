Feature: HealthCheck

    Scenario: HealthCheck-OK- Consultar la operatividad del sistema
    Given url  'https://restful-booker.herokuapp.com/ping'
    When method GET
    Then status 201
      * print response
      And match response =="Created"
