var robot = null;

function drawDirections(context, axisX, axisY, direction) {
  axisX = axisX - 10;
  axisY = axisY - 5;

  context.lineWidth = 1;
  context.fillStyle = "#f88f32";
  context.beginPath();

  switch (direction) {
    case 'NORTH':
      context.save();
      context.translate(10 - 3 + axisX+2, 10 - (3 + 5) + axisY);
      context.rotate(Math.PI);
      context.translate(-(10 - 3 + axisX+5),-(10 - (3 + 5) + axisY+10));
      break;
    case 'EAST':
      context.save();
      context.translate(10 - 3 + axisX+5, 10 - (3 + 5) + axisY);
      context.rotate(-Math.PI/2);
      context.translate(-(10 - 3 + axisX+5),-(10 - (3 + 5) + axisY+10));
      break;
    case 'WEST':
      context.save();
      context.translate(10 - 3 + axisX+2, 10 - (3 + 5) + axisY+5);
      context.rotate(Math.PI/2);
      context.translate(-(10 - 3 + axisX+5),-(10 - (3 + 5) + axisY+10));
      break;
    default:
      // this will be SOUTH
      break;
  }

  context.moveTo(10 - 3 + axisX, 10 - (3 + 5) + axisY);
  context.lineTo(10 + 3 + axisX, 10 - (3 + 5) + axisY);
  context.lineTo(10 + 3 + axisX, 10 - (3 - 5) + axisY);
  context.lineTo(10 + 7 + axisX, 10 - (3 - 5) + axisY);
  context.lineTo(10 + 0 + axisX, 10 - (3 - 13) + axisY);
  context.lineTo(10 - 7 + axisX, 10 - (3 - 5) + axisY);
  context.lineTo(10 - 3 + axisX, 10 - (3 - 5) + axisY);
  context.lineTo(10 - 3 + axisX, 10 - (3 + 5) + axisY);
  context.fill();
}

function Board(max_x, max_y) {
  this.max_x = max_x;
  this.max_y = max_y;
  this.max_x_coordinate = (max_x * 100) + 50;
  this.max_y_coordinate = (max_y * 100) + 50;
  this.draw = function (context) {
    // drawing y line
    for (var x = 50; x < this.max_x_coordinate + 100; x += 100) {
        context.moveTo(x, 50);
        context.lineTo(x, this.max_y_coordinate);
    }

    // drawing x line
    for (var y = 50; y < this.max_y_coordinate + 100; y += 100) {
        context.moveTo(50, y);
        context.lineTo(this.max_x_coordinate, y);
    }

    context.strokeStyle = "#000";
    context.stroke();
  }
}

function Robot(x, y, f) {
    this.x = x;
    this.y = y;
    this.f = f;
    this.draw = function(context,board) {
      context.beginPath();
      var axisX = (this.x + 1) * 100;
      var axisY = (board.max_y - this.y) * 100;
      context.arc(axisX, axisY, 35, 0, 2 * Math.PI);
      context.stroke();
      drawDirections(context, axisX, axisY, this.f)
    }

    this.moveTo = function(direction) {
      var commands = "";
      switch (this.f) {
        case 'WEST':
          switch (direction) {
            case 'NORTH':
              commands="RIGHT MOVE";
              break;
            case 'EAST':
              commands="RIGHT RIGHT MOVE";
              break;
            case 'SOUTH':
              commands="LEFT MOVE";
              break;
            default:
              commands="MOVE";
          }
          break;

        case 'NORTH':
          switch (direction) {
            case 'EAST':
              commands="RIGHT MOVE";
              break;
            case 'SOUTH':
              commands="RIGHT RIGHT MOVE";
              break;
            case 'WEST':
              commands="LEFT MOVE";
              break;
            default:
              commands="MOVE";
          }
          break;

        case 'EAST':
          switch (direction) {
            case 'SOUTH':
              commands="RIGHT MOVE";
              break;
            case 'WEST':
              commands="RIGHT RIGHT MOVE";
              break;
            case 'NORTH':
              commands="LEFT MOVE";
              break;
            default:
              commands="MOVE";
          }
          break;

        case 'SOUTH':
          switch (direction) {
            case 'WEST':
              commands="RIGHT MOVE";
              break;
            case 'NORTH':
              commands="RIGHT RIGHT MOVE";
              break;
            case 'EAST':
              commands="LEFT MOVE";
              break;
            default:
              commands="MOVE";
          }
          break;

      }
      $("#robot_commands").val(commands);
      $('input[type="submit"]').trigger('click');
    }
}

function initDrawingBoardAndRobot() {
    var canvas = document.getElementById("myCanvas");
    var context = canvas.getContext("2d");

    var board = new Board(parseInt($("#robot_max_x").val()), parseInt($("#robot_max_y").val()));
    robot = new Robot(parseInt($("#robot_x").val()), parseInt($("#robot_y").val()), $("#robot_f").val());

    board.draw(context);
    robot.draw(context, board);
}

