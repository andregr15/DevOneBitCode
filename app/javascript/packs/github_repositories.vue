<template>
  <div>
    <GithubRepositories :portfolioId='this.portfolioId'></GithubRepositories>
  </div>
</template>

<script>
  import GithubRepositories from './components/github_repositories';

  export default {
    props: ['portfolioId'],
    data() {
      return { }
    },
    components: {
      GithubRepositories,
    }
  }
</script>
