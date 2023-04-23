<template>
  <router-view />
</template>

<style lang="scss">
html,
body {
  box-sizing: border-box;
  height: 100%;
  margin: 0px;
}

#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  height: 100%;
}

h1 { font-size: 2rem; }
h2 { font-size: 1.8rem; }
h3 {
  font-size: 1.6rem;
  margin-top: 0.6rem;
  margin-bottom: 0.6rem;
}

a {
  color: #2c3e50;

  &.router-link-exact-active {
    color: #42b983;
  }

  &.bold {
    font-weight: bold;
  }
}

ul {
  padding-left: 0rem;
}

li {
  list-style-type: none;

  &.list {
    padding: 1rem;
    border: solid 1px;
    border-bottom: none;

    &:last-child {
      border-bottom: solid 1px;
    }
  }
}
</style>
