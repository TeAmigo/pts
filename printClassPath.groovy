// <2014-05-10 Sat 16:11> Copied from http://jnorthr.wordpress.com/2013/06/08/see-groovy-classpath/

def printClassPath(classLoader) {
  println "$classLoader"
  classLoader.getURLs().each {url->
     println "- ${url.toString()}"
  }
  if (classLoader.parent) {
     printClassPath(classLoader.parent)
  }
}

printClassPath this.class.classLoader