'use strict'

angular.module('gradeCalcNgApp')
  .controller 'MainCtrl', ($scope) ->
    $scope.currentGrade =
      midterm: 70
      quizzes: 85
      presentations: 2
      absences: 0

    $scope.projectedGrade = ->
      presentationGrade = switch $scope.currentGrade.presentations
        when 0 then 0
        when 1 then 40
        when 2 then 80
        else 100
      attendanceGrade = switch $scope.currentGrade.absences
        when 0,1 then 100
        when 2 then 90
        when 3 then 60
        when 4 then 30
        else -800
      return {
        midterm: $scope.currentGrade.midterm
        quiz: Math.min $scope.currentGrade.quizzes*2,200
        presentations: presentationGrade
        attendance: attendanceGrade
        classParticipation: 100
        participation: ->
          @classParticipation + presentationGrade + attendanceGrade
        total: ->
          @midterm + @quiz + @participation()
      }

    $scope.neededOnFinal = ->
      return {
        A: 720 - $scope.projectedGrade().total()
        B: 640 - $scope.projectedGrade().total()
        C: 560 - $scope.projectedGrade().total()
        D: 480 - $scope.projectedGrade().total()
      }


