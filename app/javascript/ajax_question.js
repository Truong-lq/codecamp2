function AjaxQuestion() {
  if (!(this instanceof AjaxQuestion)) return new AjaxQuestion()

  this.init = function () {
    AjaxQuestion().addTextToLabel()
    AjaxQuestion().add()
    AjaxQuestion().removeAnswer()
    AjaxQuestion().addAnswer()
    AjaxQuestion().submit()
    AjaxQuestion().initCorrect()
  }

  this.addTextToLabel = function () {
    const questions = $('#questions .question-item')

    questions.each(function (index) {
      const question = $(this)
      const label = question.find('.question-label')
      const answers = question.find('.answers .answer-item')

      label.text(`Question ${index + 1}`)

      answers.each(function (index) {
        const answer = $(this)
        const label = answer.find('.answer-label')

        label.text(`${index + 1}.`)
      })
    })
  }

  this.initCorrect = function () {
    const questions = $('#questions .question-item')

    questions.each(function () {
      const answers = $(this).find('.answers .answer-item')

      answers.each(function () {
        const radio = $(this).find(':radio')

        if (radio.attr('checked') === 'checked') radio.prop('checked', true)
      })
    })
  }

  this.add = function () {
    const questions = $('#questions')
    const addBtn = $('#add-question-btn')
    const template = $('#question-template').html()

    addBtn.on('click', function () {
      const newIndex = $('.question-item').length - 1
      const newQuestion = template
        .replace(/\[questions_attributes\]\[\d+\]/g, `[questions_attributes][${newIndex}]`)
        .replace(/questions_attributes_\d+/g, `questions_attributes_${newIndex}`)

      questions.append(newQuestion)
      AjaxQuestion().addTextToLabel()
      AjaxQuestion().removeAnswer()
      AjaxQuestion().addAnswer()
    })
  }

  this.removeAnswer = function () {
    const quesItems = $('.question-item')

    quesItems.each(function () {
      const item = $(this)
      const answers = item.find('.answers').children()

      answers.each(function () {
        const answer = $(this)
        const removeBtn = answer.find('.remove-answer-btn')
        const destroyInput = answer.find('._destroy')

        removeBtn.on('click', function () {
          const length = item.find('.answers .answer-item').length

          if (length > 2) {
            destroyInput.val(true)
            answer.replaceWith(destroyInput)
            AjaxQuestion().addTextToLabel()
          }
        })
      })
    })
  }

  this.addAnswer = function () {
    const quesItems = $('.question-item')

    quesItems.each(function () {
      const item = $(this)
      const addBtn = item.find('.add-answer-btn')
      const answers = item.find('.answers')
      const template = item.find('.answer-template').children().first().prop('outerHTML')

      addBtn.off().on('click', function () {
        const newIndex = answers.find('.answer-item').length
        const newAnswer = template
          .replace(/\[answers_attributes\]\[\d+\]/g, `[answers_attributes][${newIndex}]`)
          .replace(/answers_attributes_\d+/g, `answers_attributes_${newIndex}`)

        if (newIndex < 5) answers.append(newAnswer)

        AjaxQuestion().addTextToLabel()
        AjaxQuestion().removeAnswer()
      })
    })
  }

  this.submit = function () {
    $('#submit-btn').on('click', function () {
      $('#question-template').remove()
      $('.answer-template').remove()

      $('.answers').each(function () {
        const item = $(this)
        const checkedRadio = item.find(':checked')

        if (checkedRadio) {
          const originName = checkedRadio.prop('name')
          const answerId = checkedRadio.val()
          const newName = `${originName}[answers_attributes][${answerId}][is_correct]`

          checkedRadio.attr('name', newName)
          checkedRadio.val(true)

          console.log(newName)
        }
      })
    })
  }
}

AjaxQuestion().init()
