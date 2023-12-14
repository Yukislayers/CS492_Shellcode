int main(int return_address)

{
  int exit_status;
  
  if (return_address < 2) {
    problematic();
    exit_status = 0;
  }
  else {
    exit_status = -1;
  }
  return exit_status;
}