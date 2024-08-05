Feature: GetBookingIds

  Background:
* def queryfirstname = read('classpath:src/test/java/features/Booking/queryfirstname.json');

* def querylastname = read('classpath:src/test/java/features/Booking/querylastname.json');
* def querycheckin = read('classpath:src/test/java/features/Booking/querycheckin.json');
* def querycheckout = read('classpath:src/test/java/features/Booking/querycheckout.json');
* def Allparams = read('classpath:src/test/java/features/Booking/allparams.json');

  Scenario Outline: GetBookingIds-OK-Consultar listado de reservas con <dato>
    Given url 'https://restful-booker.herokuapp.com/booking'
    And params <list_params>
    When method GET
    Then status 200
    * print response
    And match response <result>
    Examples:
      | dato                  | list_params    | firstname! | lastname! | checkin!     | checkout!    | result                              |
      | firstname existente   | queryfirstname | Sally      |           |              |              | contains { 'bookingid': '#notnull'} |
      | lastname existente    | querylastname  |            | Brown     |              |              | contains { 'bookingid': '#notnull'} |
      | checkin  existente    | querycheckin   |            |           | "2018-01-01" |              | contains { 'bookingid': '#notnull'} |
      | checkout existente    | querycheckout  |            |           |              | "2019-01-01" | contains { 'bookingid': '#notnull'} |
      | firstname inexistente | queryfirstname | Sa         |           |              |              | response ==[]                       |
      | lastname inexistente  | querylastname  |            | Bre       |              |              | response ==[]                       |

  Scenario Outline: GetBookingIds-No OK-Consultar listado de reservas con <dato>
    Given url 'https://restful-booker.herokuapp.com/booking'
    And params <list_params>
    When method GET
    Then status 500
    * print response
    Examples:
      | dato                   | list_params  | firstname! | lastname! | checkin! | checkout! |
      | todos los datos vacios | Allparams    | null       | null      | null     | null      |
      | checkin  inválido      | querycheckin |            |           | rtrt     |           |
      | checkout inválido      | querycheckout    |            |           |          | ytrtt     |

