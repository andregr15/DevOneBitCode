<template>
  <div class="bloco-educacao">
    <h4 class="block-title grey">Educação</h4>
    <div class="row">
      <div class="input-field col l6 m6 s12">
        <input type="text" class="font_20 custom-grey-text text-darken-1" id="education-title" v-model="education.title" />
        <label for="education-title" class="font_20 custom-grey-text text-darken-1">Título do curso</label>
      </div>

      <div class="input-field col l6 m6 s12">
        <input type="text" class="font_20 custom-grey-text text-darken-1" id="education-institution" v-model="education.institution" />
        <label for="education-institution" class="font_20 custom-grey-text text-darken-1">Instituição</label>
      </div>

      <div class="input-field col l12 m12 s12">
        <textarea name="education-description" id="education-description" cols="30" rows="10" class="font_20 custom-grey-text text-darken-1 materialize-textarea" v-model="education.description">
        </textarea>
        <label for="education-description" class="font_20 custom-grey-text text-darken-1">Descrição</label>
      </div>

      <div class="input-field col l4 m4 s6">
        <input class="datepicker font_20 custom-grey-text text-darken-1" data-attribute="start_date" v-model="education.start_date" id="education-start-date" />
        <label for="education-start-date" class="active font_20 custom-grey-text text-darken-1">Data de Entrada</label>
      </div>

      <div class="input-field col l4 m4 s6">
        <input class="datepicker font_20 custom-grey-text text-darken-1" data-attribute="end_date" v-model="education.end_date" id="education-end-date" />
        <label for="education-end-date" class="active font_20 custom-grey-text text-darken-1">Data de Saída</label>
      </div>

      <div class="input-field col l4 m4 s6">
        <button class="btn" type="button" id="add-education" @click="submit()">Adicionar</button>
      </div>
    </div>

    <div class="row resource-list" :key="education.title" v-for="education in educations">
      <div class="col l12 m12 s12">
        <div class="row resource-item resource-education">
          <div class="col l5 m5 s5 center">{{ education.title }}</div>
          <div class="col l1 m1 s1 center">/</div>
          <div class="col l5 m5 s5 center">{{ education.institution }}</div>
          <div class="col l1 m1 s1">
            <a class="fa fa-times grey-text remove-education" @click="removeEducation(education)"></a>
          </div>
        </div>
      </div>
    </div>

  </div>
</template>

<script>
  export default {

    props: ["portfolioId"],

    data() {
      return {
        education: { },
        educations: []
      }
    },

    created() {
      this.$resource('/portfolios{/portfolioId}/educations')
          .get({ portfolioId: this.portfolioId })
          .then(
            response => this.educations = (response.body.resource != null) ? response.body.resource : [],
            error => M.toast({
              html: "Ocorreu um erro ao carregar as Educações",
              classes: "red"
            })
          );
    },

    mounted() {
      let elems = document.querySelectorAll(".datepicker");
      let vue = this;
      M.Datepicker.init(elems, {
        format: "dd/mm/yyyy",
        onClose: function() {
          console.log(this);
          let attribute = this.el.dataset.attribute;
          vue.education[attribute] = this.el.value
        }
      });
    },

    methods: {
      submit() {
        this.$resource('/portfolios{/portfolioId}/educations')
            .save(
              { portfolioId: this.portfolioId },
              { education: this.education }
            ).then(
              response => this.educations.push(response.body.resource),
              errors => errors.body.errors.forEach(
                error => M.toast({
                  html: error,
                  classes: "red"
                })
              )
            );
      },

      removeEducation(education) {
        this.$resource('/portfolios{/portfolioId}/educations{/id}')
            .remove({
              portfolioId: this.portfolioId,
              id: education.id
            }).then(
              response => {
                let indexToRemove = this.educations.indexOf(education);
                this.educations.splice(indexToRemove, 1);
              },
              errors => errors.body.errors.forEach(
                error => M.toast({
                  html: error,
                  classes: "red"
                })
              )
            );
      }
    }
  }
</script>
