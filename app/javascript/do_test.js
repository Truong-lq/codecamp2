function DoTest() {
  if (!(this instanceof DoTest)) return new DoTest()

  this.keepUserAnswer = function () {
    const answers = $('.js-answer-input')

    answers.each(function () {
      const answer = $(this)
      const questionId = answer.attr('name')
      const answerId = answer.attr('value')
      const selectedAnsId = localStorage.getItem(questionId)

      if (answerId == selectedAnsId) {
        answer.prop('checked', true)
      }

      answer.on('change', function () {
        localStorage.setItem(questionId, answerId)
      })
    })
  }
}

DoTest().keepUserAnswer()
