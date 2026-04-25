#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <error.h>
#include <errno.h>

static void usage(char *s) {
  if(s) perror(s);
  fputs("Usage: trim [FILE]...\n",stderr);
  exit(EXIT_FAILURE);
}

static char *trim_line(char *s) {
  size_t len = strlen(s);
  
  while (len > 0 && isspace(s[len - 1])) len--;
  s[len] = '\0';

  while (s < s+len && isspace(*s)) s++;
  return s;
}

void print_trim_file(FILE *fp) {
  while(true)  {
    char   *line = NULL;
    size_t  l = 0;
 
    ssize_t n = getline(&line, &l, fp);
    if(n==-1) return;
  
    char *trimmed = trim_line(line);
    puts(trimmed);
    free(line);
  }
}

int main(int args, char *argv[]) {
  if(args == 1) print_trim_file(stdin); 
  else for (int i=1; i<args; i++) {
      FILE *fp = fopen(argv[i], "r");
      if(!fp) usage(argv[i]);
      print_trim_file(fp);
      fclose(fp);
    }      
}
