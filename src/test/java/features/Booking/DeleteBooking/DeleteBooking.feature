Feature: DeleteBooking
  Scenario Outline: DeleteBooking-<estado_caso> - Eliminar reserva <descripción_caso>
    Given url 'https://restful-booker.herokuapp.com/booking/'
    And header Accept = 'application/json'
    And header Authorization = 'Basic YWRtaW46cGFzc3dvcmQxMjM='
    And path <id>
    When method DELETE
    Then status <status>
    * print response
    And match response ==<response>
    Examples:
      | estado_caso | descripción_caso |id   |status  |response            |
      | OK          | existente        |164  |  201   |"Created"           |
      | No OK       | inexistente      |14676|  405   |"Method Not Allowed"|