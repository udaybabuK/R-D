var app= angular.module('microSaveapp',[]);
app.controller('indexController', function ($scope, $http){
 
//setting page
    $scope.fetchsettingDetails = function() {
        $http.get('https://api.myjson.com/bins/41dpi').success(function(data) {
           /* debugger;*/
            console.log(data);
            $scope.settings=data;
        });
    }

  
  //new goals page   
    $scope.fetchnewgoalDetails = function() {
        $http.get('https://api.myjson.com/bins/3ll42').success(function(data) {
           /* debugger;*/
            console.log(data);
            $scope.newgoal=data;
        });
    }
 

//goals page

  $scope.fetchgoalsDetails = function() {
    $http.get('https://api.myjson.com/bins/2rkv6').success(function(data) {
       /* debugger;*/
        console.log(data);
        $scope.goals=data;
    });
}




//goals16
$scope.getaccountDetails = function() {
    $http.get('https://api.myjson.com/bins/thsw').success(function(data) {
    
      console.log(data);
        $scope.accountdetails=data;
    });
}

});
