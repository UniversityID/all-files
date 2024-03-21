-- Create Auditorium table
CREATE TABLE dbo.Auditorium
(
    Auditorium_ID INT PRIMARY KEY,
    AuditoriumNumber VARCHAR(50) NOT NULL,
    AuditoriumType VARCHAR(50) NOT NULL,
    Level INT NOT NULL,
    Building_ID INT NOT NULL,
    Capacity INT NOT NULL,
    Equipment TEXT NOT NULL,
    Accessibility BIT NOT NULL
);

-- Create Building table
CREATE TABLE dbo.Building
(
    Building_ID INT PRIMARY KEY,
    BuildingName VARCHAR(50) NOT NULL
);

-- Create FreeTime table
CREATE TABLE dbo.FreeTime
(
    FreeTime_ID INT PRIMARY KEY,
    Auditorium_ID INT NOT NULL,
    Building_ID INT NOT NULL,
    Free_time_start TIME NOT NULL,
    Free_time_end TIME NOT NULL,
    Status BIT NOT NULL,
    CONSTRAINT FK_FreeTime_Auditorium FOREIGN KEY (Auditorium_ID) REFERENCES dbo.Auditorium(Auditorium_ID),
    CONSTRAINT FK_FreeTime_Building FOREIGN KEY (Building_ID) REFERENCES dbo.Building(Building_ID)
);

-- Create Image table
CREATE TABLE dbo.Image
(
    Image_ID INT PRIMARY KEY,
    ImageFile VARCHAR(100) NOT NULL,
    Auditorium_ID INT NOT NULL,
    CONSTRAINT FK_Image_Auditorium FOREIGN KEY (Auditorium_ID) REFERENCES dbo.Auditorium(Auditorium_ID)
);

-- Create Map table
CREATE TABLE dbo.Map
(
    Map_ID INT PRIMARY KEY,
    MapName VARCHAR(50) NOT NULL,
    MapFile VARCHAR(100) NOT NULL,
    Building_ID INT NOT NULL,
    CONSTRAINT FK_Map_Building FOREIGN KEY (Building_ID) REFERENCES dbo.Building(Building_ID)
);

-- Create Reservation table
CREATE TABLE dbo.Reservation
(
    Resevation_ID INT PRIMARY KEY,
    User_ID INT NOT NULL,
    Auditorium_ID INT NOT NULL,
    ReservationGoal VARCHAR(100) NOT NULL,
    Status BIT NOT NULL,
    FreeTime_ID INT NOT NULL,
    CONSTRAINT FK_Reservation_User FOREIGN KEY (User_ID) REFERENCES dbo.[User](User_ID),
    CONSTRAINT FK_Reservation_Auditorium FOREIGN KEY (Auditorium_ID) REFERENCES dbo.Auditorium(Auditorium_ID),
    CONSTRAINT FK_Reservation_FreeTime FOREIGN KEY (FreeTime_ID) REFERENCES dbo.FreeTime(FreeTime_ID)
);

-- Create Timetable table
CREATE TABLE dbo.Timetable
(
    Auditorium_ID INT PRIMARY KEY,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    Status BIT,
    CONSTRAINT FK_Timetable_Auditorium FOREIGN KEY (Auditorium_ID) REFERENCES dbo.Auditorium(Auditorium_ID)
);

-- Create User table
CREATE TABLE dbo.[User]
(
    User_ID INT PRIMARY KEY,
    First_name VARCHAR(50) NOT NULL,
    Last_name VARCHAR(50) NOT NULL,
    Contact_information VARCHAR(100) NOT NULL,
    Faculty VARCHAR(50) NOT NULL,
    GroupNumber INT NOT NULL,
    Role VARCHAR(50) NOT NULL,
    Reservation_ID INT NOT NULL,
    CONSTRAINT FK_User_Reservation FOREIGN KEY (Reservation_ID) REFERENCES dbo.Reservation(Resevation_ID)
);

-- Create UserKab table
CREATE TABLE dbo.UserKab
(
    UserKab_ID INT PRIMARY KEY,
    User_ID INT NOT NULL,
    Reservation_ID INT NOT NULL,
    CONSTRAINT FK_UserKab_User FOREIGN KEY (User_ID) REFERENCES dbo.[User](User_ID),
    CONSTRAINT FK_UserKab_Reservation FOREIGN KEY (Reservation_ID) REFERENCES dbo.Reservation(Resevation_ID)
);
