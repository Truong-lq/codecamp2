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

  this.onSubmitBtnClick = function () {
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
        DoTest().handleSubmit(testId)
      }
    })
  }

  this.setTimer = function () {
    const timer = $('#js-test-timer')
    const testId = timer.data('test_id')

    if (testId) {
      let startTime = localStorage.getItem(`testId_${testId}`)

      if (!startTime) {
        startTime = Date.now()
        localStorage.setItem(`testId_${testId}`, startTime)
      }

      const fifteenMinutes = 15 * 60 * 1000
      const currentTime = Date.now()
      let timeLeft = (fifteenMinutes - (currentTime - Number(startTime))) / 1000
      let countdown

      // Display timer when access page
      DoTest().displayTime(timer, timeLeft)

      countdown = setInterval(function () {
        if (timeLeft <= 0) {
          clearInterval(countdown)
          alert("Time's up!")
          DoTest().handleSubmit(testId)
        } else {
          timeLeft--
          DoTest().displayTime(timer, timeLeft)
        }
      }, 1000)
    }
  }

  this.displayTime = function (timer, timeLeft) {
    const leftMinutes = Math.floor(timeLeft / 60)
    const leftSeconds = Math.floor(timeLeft - leftMinutes * 60)
    timer.text(`${leftMinutes} : ${leftSeconds}`)
  }

  this.handleSubmit = function (testId) {
    const submitBtn = $('#js-submit-test-btn')
    const questionIds = submitBtn.data('question-ids')
    const data = {}

    questionIds?.forEach((questionId) => {
      const answerId = localStorage.getItem(questionId)
      data[questionId] = answerId
    })

    $.ajax({
      url: `/tests/${testId}/submit`,
      method: 'POST',
      contentType: 'application/json',
      data: JSON.stringify({ data: data }),
      success: (res) => {
        questionIds?.forEach((questionId) => {
          localStorage.removeItem(questionId)
        })
        localStorage.removeItem(`testId_${testId}`)
        window.location.href = `/tests/${testId}/results/${res.result_id}`
      },
      error: (err) => {
        alert(err.responseJSON.msg)
        window.location.href = '/'
      },
    })
  }
}

DoTest().keepUserAnswer()
DoTest().onSubmitBtnClick()
DoTest().setTimer()
