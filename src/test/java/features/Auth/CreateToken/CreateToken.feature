Feature: CreateToken
  Background:
    * def requestPayload = read('classpath:src/test/java/features/Auth/CreateToken/CreateToken.json');

  Scenario Outline: CreateToken-NO OK-Crear token con <dato>
    Given url 'https://restful-booker.herokuapp.com/auth'
    And request requestPayload
    When method post
    Then status 200
    * print requestPayload
    * print response
    And match $response.reason == '#(errorResponse)'
    Examples:
      | dato                | username!     | password!   | errorResponse!  |
      | username incorrecto | administrador | password123 | Bad credentials |
      | password incorrecto | admin         | password    | Bad credentials |
      | usuario vacio       | null          | password123 | Bad credentials |
      | password vacio      | admin         | null        | Bad credentials |

  Scenario Outline: CreateToken-OK-Crear token con username y password correctos
    Given url 'https://restful-booker.herokuapp.com/auth'
    And request requestPayload
    When method post
    Then status 200
    * print requestPayload
    * print response
    And match response == { 'token': '#notnull'}
    Examples:
      | username! | password!   |
      | admin     | password123 |