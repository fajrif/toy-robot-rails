var commandInitiated;
var errorMessage;
var reportMessage;

var facing;
var maxX;
var maxY;

var robot;
var currentPos;

var canvas;
var context;

function writeError(msg) {
    errorMessage.innerHTML = msg;
}

function validX(axis) {
    if (isNaN(axis)) {
        writeError("Please enter a numeric X coordinates!");
        return false;
    } else if (axis < 0 || axis > maxX) {
        writeError("X coordinates out of range!");
        return false;
    } else {
        return true;
    }
}

function validY(axis) {
    if (isNaN(axis)) {
        writeError("Please enter a numeric Y coordinates!");
        return false;
    } else if (axis < 0 || axis > maxY) {
        writeError("Y coordinates out of range!");
        return false;
    } else {
        return true;
    }
}

function validF(face) {
    if (facing.indexOf(face) === -1) {
        writeError("Wrong facing!");
        return false;
    } else {
        return true;
    }
}

function Robot(x, y, f) {
    this.x = x;
    this.y = y;
    this.f = f;
}

function place(posCmd) {
    var newPos = posCmd.split(","); // get x y f from the command
    var newX = parseInt(newPos[0].trim());
    var newY = parseInt(newPos[1].trim());
    var newF = newPos[2].trim().toUpperCase();
    if (validX(newX) && validY(newY) && validF(newF)) {
        robot.x = newX;
        robot.y = newY;
        robot.f = newF;
        drawRobot(robot);
    }
}

function move() {
    switch (currentPos.f) {
        case "NORTH":
            var newY = currentPos.y + 1;
            if (validY(newY)) {
                robot.y = newY;
                drawRobot(robot);
            }
            break;
        case "SOUTH":
            var newY = currentPos.y - 1;
            if (validY(newY)) {
                robot.y = newY;
                drawRobot(robot);
            }
            break;
        case "EAST":
            var newX = currentPos.x + 1;
            if (validX(newX)) {
                robot.x = newX;
                drawRobot(robot);
            }
            break;
        case "WEST":
            var newX = currentPos.x - 1;
            if (validX(newX)) {
                robot.x = newX;
                drawRobot(robot);
            }
            break;
        default:
            break;
    }
}

function rotate(direction) {
    if (direction === "left") {
        switch (currentPos.f) {
            case "NORTH":
                robot.f = "WEST";
                break;
            case "SOUTH":
                robot.f = "EAST";
                break;
            case "EAST":
                robot.f = "NORTH";
                break;
            case "WEST":
                robot.f = "SOUTH";
                break;
            default:
                break;
        }
    } else if (direction === "right") {
        switch (currentPos.f) {
            case "NORTH":
                robot.f = "EAST";
                break;
            case "SOUTH":
                robot.f = "WEST";
                break;
            case "EAST":
                robot.f = "SOUTH";
                break;
            case "WEST":
                robot.f = "NORTH";
                break;
            default:
                break;
        }
    }
}

function report() {
    reportMessage.innerHTML = robot.x + "," + robot.y + "," + robot.f;
}

function processCommand(command) {
    console.log(command);
    writeError(""); // clear error message

    currentPos = {
        x: robot.x,
        y: robot.y,
        f: robot.f
    };
    var completeCmd = command.split(" ");
    var literalCmd = completeCmd[0].toUpperCase(); // get either PLACE, MOVE, LETF, RIGHT, REPORT or soemthing else

    if (commandInitiated) {
        switchLiteralCommand(literalCmd, completeCmd);
    } else if ((!commandInitiated && literalCmd === 'PLACE')) {
        commandInitiated = true;
        var posCmd = completeCmd.slice(1).join(""); // avoid scenarios when user types extra spaces after coordinates e.g. place 2, 2,  north
        place(posCmd);
    } else {
        writeError("The first valid command to the robot must be a PLACE command!");
    }
}

function switchLiteralCommand(literalCmd, completeCmd) {
    switch (literalCmd) {
        case "PLACE":
            var posCmd = completeCmd.slice(1).join(""); // avoid scenarios when user types extra spaces after coordinates e.g. place 2, 2,  north
            place(posCmd);
            break;
        case "MOVE":
            move();
            break;
        case "LEFT":
            rotate("left");
            break;
        case "RIGHT":
            rotate("right");
            break;
        case "REPORT":
            report();
            break;
        default:
            writeError("Invalid command!");
            break;
    }

}

function clearCurrentRobot(currentX, currentY) {
    var axisX = currentX * 100 + 51;
    var axisY = (5 - currentY) * 100 - 49;
    context.clearRect(axisX, axisY, 98, 98);
}

function drawRobot(newRobot) {
    clearCurrentRobot(currentPos.x, currentPos.y); // clear the current robot first
    context.beginPath();
    var axisX = (newRobot.x + 1) * 100;
    var axisY = (5 - newRobot.y) * 100;
    context.arc(axisX, axisY, 35, 0, 2 * Math.PI);
    context.stroke();
}

function init() {
    commandInitiated = false;
    errorMessage = document.getElementById("error");
    reportMessage = document.getElementById("report");

    facing = ['NORTH', 'SOUTH', 'EAST', 'WEST'];
    maxX = 4;
    maxY = 4;

    robot = null;
    currentPos = {};

    canvas = document.getElementById("myCanvas");
    context = canvas.getContext("2d");

    for (var x = 50; x < 650; x += 100) {
        context.moveTo(x, 50);
        context.lineTo(x, 550);
    }

    for (var y = 50; y < 650; y += 100) {
        context.moveTo(50, y);
        context.lineTo(550, y);
    }

    context.strokeStyle = "#000";
    context.stroke();

    robot = new Robot(0, 0, "NORTH");
    drawRobot(robot);
}

