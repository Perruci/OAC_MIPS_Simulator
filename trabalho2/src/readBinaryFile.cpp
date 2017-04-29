#include <stdio.h>
#include <string.h>

#include <iostream>
#include <fstream>
#include <iterator>
#include <bitset>

#define MEM_SIZE 4096
int32_t mem[MEM_SIZE];

void printAddressValues( int32_t, int32_t, char format = 'h' );

void allocateValueOnMemory( size_t, int32_t );

int printBinFile( std::string, char format = 'h' );

int main( int argc, char* argv[] ) {

	if( argc == 1 )
		return 0;

	int size;

	size = printBinFile( argv[1] );

	std::cout << "Size: " << size << '\n';

	return 0;
}

void printAddressValues( int32_t addr, int32_t value, char format )
{
	// Print as Hexadecimal Values (default)
	if( format == 'h' )
		printf("%#010x \t = \t %#010x\n", addr, value );
		// ref: http://stackoverflow.com/questions/14733761/printf-formatting-for-hex
	// Print as Decimal Values
	else if( format == 'd' )
		std::cout << addr << "\t = \t" << value << '\n';
	// Invalid input
	else
		std::cout << "Invalid Formatation Requested." << '\n';
}

void allocateValueOnMemory( size_t position, int32_t value )
{
	if( position < MEM_SIZE )
		mem[ position ] = value;
}

int printBinFile( std::string fileName, char format )
{
	if( format != 'h' && format != 'd' )
	{
		std::cout << "Invalid format input" << '\n';
		return -1;
	}
	std::ifstream myfile; // File stream for reading
	myfile.open ( fileName,  std::ios::in|std::ios::binary );

	uint32_t binValue;

	std::streampos fileSize;

	if( myfile.is_open() )
	{
		// Move to the end of the file
		myfile.seekg( 0, std::ios::end );
		// Get file size (get file pointer position at the end = file size)
		fileSize = myfile.tellg();
		// Return to beginning
		myfile.seekg( 0, std::ios::beg );

		std::cout << "Memory" << '\n';
		// Loop over the file
		size_t position = myfile.tellg();
		while( position < fileSize )
		{
			// Read binary value from file.
			// Cating as a char* avoids warnings when passing pointer as reference
			myfile.read(reinterpret_cast<char *>(&binValue), sizeof(binValue));
			// ref: http://stackoverflow.com/questions/3595136/c-cout-hex-format
			// Prnt addresses and its values
			printAddressValues( position, binValue );
			allocateValueOnMemory( position, binValue );
			// Update Positon values
			position = myfile.tellg();
			// Wait for reading
			// getchar();
		}

		myfile.close();
	}
	else
	{
		std::cout << "Error when opening file" << '\n';
		return 0;
	}
	return fileSize;
}
