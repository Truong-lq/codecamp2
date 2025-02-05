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

  this.submit = function () {
    const submitBtn = $('#js-submit-test-btn')

    submitBtn.on('click', function () {
      const questionIds = submitBtn.data('question-ids')
      const testId = submitBtn.data('test-id')
      const data = {}

      questionIds.forEach((questionId) => {
        const answerId = localStorage.getItem(questionId)
        data[questionId] = answerId
      })

      const nullExist = Object.values(data).some((value) => value === null)

      if (nullExist) {
        alert('Please complete the test before submit!')
      } else {
        $.ajax({
          url: `/tests/${testId}/submit`,
          method: 'POST',
          contentType: 'application/json',
          data: JSON.stringify({ data: data }),
          success: () => {
            window.location.href = '/'
          },
        })

        questionIds.forEach((questionId) => {
          localStorage.removeItem(questionId)
        })
      }
    })
  }
}

DoTest().keepUserAnswer()
DoTest().submit()
