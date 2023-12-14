void problematic(void)

{
  char str [512];
  
  fgets(str,0x1ff,stdin);
  fprintf(stdout,str);
  return;
}