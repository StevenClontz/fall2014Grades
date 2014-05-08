'use strict'

class Grade
  constructor: (@score, @maxScore) ->
  ratio: =>
    @score / @maxScore
  percentage: =>
    @ratio() * 100
  display: =>
    """
    #{@percentage().toFixed(1)}%
    (#{@score.toFixed(1)}/#{@maxScore.toFixed(1)})
    """

angular.module('gradeCalcNgApp')
  .controller 'MainCtrl', ($scope) ->
    $scope.currentGrade = new Grade(86, 100) 
    $scope.finalWeight = new Grade(35, 100)
    $scope.desiredGrade = new Grade(90, 100)

    $scope.neededForFinal = ->
      overallRatioEarned = 
        $scope.currentGrade.ratio() * 
        (1 - $scope.finalWeight.ratio())
      overallRatioNeeded =
        $scope.desiredGrade.ratio() - overallRatioEarned
      finalRatioNeeded = 
        overallRatioNeeded / $scope.finalWeight.ratio()
      finalScoreNeeded =
        finalRatioNeeded * $scope.finalWeight.score
      new Grade(finalScoreNeeded, $scope.finalWeight.score)

    $scope.bestGrade = ->
      overallRatioEarned = 
        $scope.currentGrade.ratio() * 
        (1 - $scope.finalWeight.ratio())
      bestRatioPossible =
        $scope.finalWeight.ratio() + overallRatioEarned
      bestScorePossible =
        bestRatioPossible * $scope.desiredGrade.maxScore
      new Grade(bestScorePossible, $scope.desiredGrade.maxScore)

